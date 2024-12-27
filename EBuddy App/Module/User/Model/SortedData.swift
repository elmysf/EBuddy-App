//
//  SortedData.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import Foundation

enum SortedData: String, CaseIterable, Identifiable {
    case lastActive = "last_active"
    case rating = "rating"
    case price = "price"

    var id: String { self.rawValue }
}
