//
//  AuthorizationViewModel.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 04/01/21.
//

import Foundation

protocol AuthorizationViewModelDelegate {
    func singin(with username: String?, password: String?)
}

class AuthorizationViewModel: AuthorizationViewModelDelegate {
    var api = APIService()
    var delegate: LoginControllerDelegate?
    func singin(with username: String?, password: String?) {
        guard let username = username else { return }
        guard let password = password else { return }
        api.getAuthorizationUser(user: username, password: password) { result in
            switch result {
            case let .success(auth):
                self.delegate?.getUserAutorizationAndSaveData(handelData: auth)
            case let .failure(error):
                self.delegate?.showErrorAlert(errorMessages: error.rawValue)
            }
        }
    }
}
