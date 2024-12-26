//
//  CardUserViewModel.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import Combine
import Foundation
import SwiftUI

class CardUserViewModel: ObservableObject {
    
    @Published var userData: [UserJsonModel] = []
    @Published var errorMessage: String? = nil
    
    private let firebaseManager: FirebaseManagers
    private var cancellables = Set<AnyCancellable>()
    
    init(firebaseManager: FirebaseManagers = FirebaseManagers()) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchUsers() {
        firebaseManager.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] users in
                self?.userData = users
            })
            .store(in: &cancellables)
    }
    
    func uploadImage(uid: String, image: UIImage) {
        firebaseManager.uploadImageUser(uid: uid, image: image)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] url in
                self?.updateImageURL(userID: uid, imageURL: url.absoluteString)
            })
            .store(in: &cancellables)
    }
    
    func updateImageURL(userID: String, imageURL: String) {
        firebaseManager.updateUserProfileImageURL(userID: userID, url: imageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] respone in
                self?.fetchUsers()
            })
            .store(in: &cancellables)
    }
}
