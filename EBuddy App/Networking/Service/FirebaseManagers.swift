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
    private let storage = Storage.storage()
    private var cancellables = Set<AnyCancellable>()

    func fetchUsers(with query: Query = FirebaseManagers.db) -> AnyPublisher<[UserJsonModel], Error> {
        Future<[UserJsonModel], Error> { promise in
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
                    let users = try documents.map { try $0.data(as: UserJsonModel.self) }
                    promise(.success(users))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func uploadImageUser(uid: String, image: UIImage) -> AnyPublisher<URL, Error> {
        var imageData: Data?
        var fileExtension: String

        if let pngData = image.pngData() {
            imageData = pngData
            fileExtension = "png"
        } else if let jpegData = image.jpegData(compressionQuality: 0.8) {
            imageData = jpegData
            fileExtension = "jpg"
        } else {
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

        let refStorage = storage
            .reference(withPath: "EBuddy-User/\(uid).\(fileExtension)")

        return Future<URL, Error> { promise in
            refStorage.putData(validImageData, metadata: nil) { metadata, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                refStorage.downloadURL { url, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let url = url {
                        promise(.success(url))
                    }
                }
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
}
