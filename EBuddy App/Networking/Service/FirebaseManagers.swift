//
//  FirebaseManagers.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseStorage

final class FirebaseManagers {
    private static let db = Firestore.firestore().collection("USERS")
    private static let sliders = Firestore.firestore().collection("SLIDERS")
    private let storage = Storage.storage()
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUsers(sortedBy: SortedData, filterByFemale: Bool) -> AnyPublisher<[UserJsonModel], Never> {
        var query: Query = FirebaseManagers.db
        
        if filterByFemale {
            query = query.whereField("ge", isEqualTo: 0)
        }
        
        switch sortedBy {
        case .lastActive:
            query = query.order(by: "last_active", descending: true)
        case .rating:
            query = query.order(by: "rating", descending: true)
        case .price:
            query = query.order(by: "price", descending: false)
        }
        
        return Future<[UserJsonModel], Never> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    print("Firestore query error: \(error.localizedDescription)")
                    promise(.success([]))
                    return
                }
                
                guard let snapshot = snapshot else {
                    promise(.success([]))
                    return
                }
                
                let users = snapshot.documents.compactMap { doc -> UserJsonModel? in
                    try? doc.data(as: UserJsonModel.self)
                }
                promise(.success(users))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchSliders(with query: Query = FirebaseManagers.sliders) -> AnyPublisher<[SliderModel], Error> {
        Future<[SliderModel], Error> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    promise(.success([]))
                    return
                }
                
                do {
                    let sliders = try documents.map { try $0.data(as: SliderModel.self) }
                    promise(.success(sliders))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func uploadImageUser(uid: String, image: UIImage, progressHandler: @escaping (Double) -> Void) -> AnyPublisher<URL, Error> {
        var imageData: Data?
        var fileExtension: String
        beginBackgroundTask()
        if let pngData = image.pngData() {
            imageData = pngData
            fileExtension = "png"
        } else if let jpegData = image.jpegData(compressionQuality: 0.8) {
            imageData = jpegData
            fileExtension = "jpg"
        } else {
            endBackgroundTask()
            return Fail(error: NSError(
                domain: "ImageError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid image data."]
            )).eraseToAnyPublisher()
        }
        
        guard let validImageData = imageData else {
            return Fail(error: NSError(
                domain: "ImageError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Unable to generate image data."]
            )).eraseToAnyPublisher()
        }
        
        let refStorage = storage.reference().child("EBuddy-User/\(uid).\(fileExtension)")
        
        return Future<URL, Error> { [weak self] promise in
            let uploadTask = refStorage.putData(validImageData, metadata: nil) { metadata, error in
                if let error = error {
                    self?.endBackgroundTask()
                    promise(.failure(error))
                    return
                }
                
                refStorage.downloadURL { url, error in
                    self?.endBackgroundTask()
                    if let error = error {
                        promise(.failure(error))
                    } else if let url = url {
                        promise(.success(url))
                    }
                }
            }
            
            uploadTask.observe(.progress) { snapshot in
                let progress = Double(snapshot.progress?.fractionCompleted ?? 0.0)
                progressHandler(progress)
            }
        }.eraseToAnyPublisher()
    }
    
    func updateUserProfileImageURL(userID: String, url: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            FirebaseManagers.db.document(userID).updateData(["profile_user": url]) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func beginBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "FirebaseUpload") {
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
    }
    
    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}
