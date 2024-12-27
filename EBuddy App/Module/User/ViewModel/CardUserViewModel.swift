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
    @Published var sortedBy: SortedData = .lastActive { didSet { fetchUsers() } }
    @Published var filterBy: Bool = false { didSet { fetchUsers() } }
    @Published var columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    private let firebaseManager: FirebaseManagers
    private var cancellables = Set<AnyCancellable>()
    
    init(firebaseManager: FirebaseManagers = FirebaseManagers()) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchUsers() {
        firebaseManager.fetchUsers(sortedBy: self.sortedBy, filterByFemale: self.filterBy)
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
                    self?.showUploadErrorAlert(message: error.localizedDescription)
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
                    self?.showUploadErrorAlert(message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] respone in
                self?.fetchUsers()
            })
            .store(in: &cancellables)
    }
    
    private func showUploadErrorAlert(message: String) {
        self.alertTitle = "Upload Failed"
        self.alertMessage = message
        self.showAlert = true
    }
    
    var currentSortLabel: String {
        switch sortedBy {
        case .lastActive:
            return "Last Active"
        case .rating:
            return "Rating"
        case .price:
            return "Price"
        }
    }
}
