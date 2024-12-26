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

final class FirebaseManagers {

    private static let database = Firestore.firestore().collection("USERS")
    private var cancellables = Set<AnyCancellable>()

    func fetchUsers(with query: Query = FirebaseManagers.database) -> AnyPublisher<[UserJsonModel], Error> {
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
}