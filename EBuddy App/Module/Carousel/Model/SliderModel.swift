//
//  SliderModel.swift
//  EBuddy App
//
//  Created by Elmo on 29/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import Foundation

struct SliderModel: Codable, Identifiable {
    let id: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case image
    }
}
