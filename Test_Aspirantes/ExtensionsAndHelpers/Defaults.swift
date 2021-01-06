//
//  Defaults.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import Foundation
struct Defaults {
    static let accessTokenKey = "accessToken"
    static let userSessionKey = "com.save.usersession"
    private static let userDefault = UserDefaults.standard

    struct UserDetails {
        let accessToken: String
        init(_ json: [String: String]) {
            accessToken = json[accessTokenKey] ?? ""
        }
    }

    static func save(_ accessToken: String) {
        userDefault.set([accessTokenKey: accessToken],
                        forKey: userSessionKey)
    }

    static func getUserDetailOf() -> UserDetails {
        return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }

    static func clearUserData() {
        userDefault.removeObject(forKey: userSessionKey)
    }
}
