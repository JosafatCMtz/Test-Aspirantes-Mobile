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
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var numberCardLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getUserProfile()
        title = "Perfil"
    }

    @IBAction func didTapButtonCardSearch() {
        let alert = UIAlertController(title: "Upss!", message: "Debido a un error de consumo de API no pude completar el paso de esta acción.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    @IBAction func didTapLogOutButton() {
        let alert = UIAlertController(
            title: "Cerrar Sesión",
            message: "Estas Seguro de desjar la sesión.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Si", style: .destructive, handler: { _ in
            Defaults.clearUserData()
            self.performSegue(withIdentifier: "segueLogOut", sender: self)
        }))
        present(alert, animated: true)
    }
}

extension ProfileController: ProfileControllerDelegate {
    func getUserProfileAndSaveData(handelData: Profile?) {
        guard let data = handelData else { return }
        usernameLabel.text = "\(data.firstName) \(data.lastName)"
        emailLabel.text = data.email
        numberCardLabel.text = data.cardNumber
    }

    func showErrorAlert(errorMessages: String) {
        let alert = UIAlertController(title: "Upss!", message: errorMessages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
