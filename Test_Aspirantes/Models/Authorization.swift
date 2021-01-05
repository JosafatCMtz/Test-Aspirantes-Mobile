//
//  Authorization.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 04/01/21.
//

import Foundation

// MARK: - Authorization
class Authorization: Codable {
    @objc dynamic var accessToken, tokenType: String
    @objc dynamic var expiresIn: Int
    @objc dynamic var refreshToken, asClientID, username, countryCode: String
    @objc dynamic var issued, expires: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case asClientID = "as:client_id"
        case username
        case countryCode = "country_code"
        case issued = ".issued"
        case expires = ".expires"
    }
}
