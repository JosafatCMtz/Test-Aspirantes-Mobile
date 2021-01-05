//
//  ViewController.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 04/01/21.
//

import UIKit

protocol LoginControllerDelegate {
    func getUserAutorizationAndSaveData(handelData: Authorization?)
    func showErrorAlert(errorMessages: String)
}

final class LoginController: UIViewController {
    private var viewModel = AuthorizationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    @IBAction func didTapOnLoginButton() {
        viewModel.singin(with: "pruebas_beto_ia@yahoo.com", password: "Pruebas01")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("prepare for segue, identifier: \(String(describing: segue.identifier))")
    }
}

extension LoginController: LoginControllerDelegate {
    func getUserAutorizationAndSaveData(handelData: Authorization?) {
        guard let data = handelData else { return }
        Defaults.save(data.accessToken)
        debugPrint(Defaults.getUserDetailOf().accessToken)
        performSegue(withIdentifier: "segueProfile", sender: self)
    }

    func showErrorAlert(errorMessages: String) {
        let alert = UIAlertController(title: "Upss!", message: errorMessages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
