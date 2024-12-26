//
//  UserJsonModel.swift
//  EBuddy App
//
//  Created by Elmo on 26/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//

import Foundation

struct UserJsonModel: Codable, Identifiable {
    let id = UUID()
    var uid: String
    var email: String
    var phoneNumber: String
    var gender: Int
    var genderEnum: GenderEnum? {
        guard let infoGender = GenderEnum(rawValue: gender) else {
            return nil
        }
        return infoGender
    }

    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case phoneNumber = "phone_number"
        case gender = "ge"
    }

    var genderInformation: String {
        switch genderEnum {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case nil:
            return ""
        }
    }
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
