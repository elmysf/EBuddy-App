//
//  CardUserViewModel.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import Combine
import Foundation

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
}
