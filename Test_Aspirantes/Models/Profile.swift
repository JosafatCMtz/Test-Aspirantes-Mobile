//
//  Profile.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//


import Foundation

// MARK: - Profile
struct Profile: Codable {
    let email, firstName, lastName, phoneNumber: String
    let profilePicture, cardNumber: String

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case profilePicture = "profile_picture"
        case cardNumber = "card_number"
    }
}
