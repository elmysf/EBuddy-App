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
    let uid: String
    let name: String?
    let price: Double?
    let rating: Double?
    let totalRating: Int?
    let isOnline: Bool?
    let isVerified: Bool?
    let isAVailable: Bool?
    let isVoiceAvailable: Bool?
    let isHaveInstagram: String?
    let email: String
    let phoneNumber: String
    let gender: Int
    let profile: String?
    var gemes: [String]?
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
        case profile = "profile_user"
        case name
        case price
        case rating
        case totalRating = "total_rating"
        case isOnline = "is_online"
        case isVerified = "is_verified"
        case isAVailable = "is_available"
        case isVoiceAvailable = "is_voice_available"
        case isHaveInstagram = "is_have_instagram"
        case gemes
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
    
    var priceNominal: String {
        return "\(price ?? 0)".components(separatedBy: ".").first ?? ""
    }
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
