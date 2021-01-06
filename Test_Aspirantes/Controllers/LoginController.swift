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

enum ValidationErrorMessages: String {
    case wrongEmail = "*Porfavor introduce un correo valido."
    case veryShortPassword = "*El número de caracteres de tu contraseña es muy corto."
    case emptyField = "*El campo no puede ir vacio."
}

final class LoginController: UIViewController {
    private var viewModel = AuthorizationViewModel()
    private var hiddenPropertyForView: Bool = true
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var errorUsernameLabel: UILabel!
    @IBOutlet var errorPasswordLabel: UILabel!

    fileprivate func setuUI() {
        activityIndicatorView.isHidden = hiddenPropertyForView
        errorUsernameLabel.isHidden = hiddenPropertyForView
        errorPasswordLabel.isHidden = hiddenPropertyForView
    }

    fileprivate func generatingErrorMessagesOn(_ label: UILabel, hiddenPropertyForView hidden: Bool, errorMessage error: ValidationErrorMessages) {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()
        label.isHidden = hidden
        label.text = error.rawValue
        label.textColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setuUI()
    }

    @IBAction func didTapOnLoginButton() {
        [errorPasswordLabel, errorUsernameLabel].forEach { (label) in
            label?.isHidden = hiddenPropertyForView
        }
        activityIndicatorView.isHidden = !hiddenPropertyForView
        activityIndicatorView.startAnimating()
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if username.isEmpty {
            generatingErrorMessagesOn(errorUsernameLabel, hiddenPropertyForView: !hiddenPropertyForView, errorMessage: .emptyField)
            return
        }
        if password.isEmpty {
            generatingErrorMessagesOn(errorPasswordLabel, hiddenPropertyForView: !hiddenPropertyForView, errorMessage: .emptyField)
            return
        }
        if !username.isEmail() {
            generatingErrorMessagesOn(errorUsernameLabel, hiddenPropertyForView: !hiddenPropertyForView, errorMessage: .wrongEmail)
            return
        }
        if password.length < 8 {
            generatingErrorMessagesOn(errorPasswordLabel, hiddenPropertyForView: !hiddenPropertyForView, errorMessage: .veryShortPassword)
            return
        }
        viewModel.singin(with: username, password: password)
    }
}

extension LoginController: LoginControllerDelegate {
    func getUserAutorizationAndSaveData(handelData: Authorization?) {
        guard let data = handelData else { return }
        Defaults.save(data.accessToken)
        performSegue(withIdentifier: "segueProfile", sender: self)
    }

    func showErrorAlert(errorMessages: String) {
        let alert = UIAlertController(title: "Upss!", message: errorMessages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (_) in
            self.activityIndicatorView.hidesWhenStopped = true
            self.activityIndicatorView.stopAnimating()
        }))
        present(alert, animated: true)
    }
}
