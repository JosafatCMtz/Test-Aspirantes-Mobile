//
//  ProfileViewModel.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import Foundation

protocol ProfileViewModelDelegate {
    func getUserProfile()
}

class ProfileViewModel: ProfileViewModelDelegate {
    var api = APIService()
    var delegate: ProfileControllerDelegate?
    func getUserProfile() {
        api.getProfileByUser { result in
            switch result {
            case let .success(profile):
                debugPrint(profile.email)
            case let .failure(error):
                debugPrint(error.rawValue)
            }
        }
    }
}
