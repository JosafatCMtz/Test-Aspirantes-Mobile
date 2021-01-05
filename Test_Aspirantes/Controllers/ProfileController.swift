//
//  ProfileController.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import UIKit

protocol ProfileControllerDelegate {
    func getUserProfileAndSaveData(handelData: Profile?)
    func showErrorAlert(errorMessages: String)
}

class ProfileController: UIViewController {
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getUserProfile()
    }
}

extension ProfileController: ProfileControllerDelegate {
    func getUserProfileAndSaveData(handelData: Profile?) {
        guard let data = handelData else { return }
        debugPrint("\(#function), \(data.email)")
    }
    
    func showErrorAlert(errorMessages: String) {
        let alert = UIAlertController(title: "Upss!", message: errorMessages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
