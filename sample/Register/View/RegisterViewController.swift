//
//  RegisterViewController.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import UIKit

class RegisterViewController: UIViewController, RegisterViewProtocol {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: RegisterButton!
    
    var presenter: RegisterPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.changeDisabled()
        passwordTextfield.isSecureTextEntry = true
        
        emailTextfield.text = Utils().randomString(length: 8) + "@gmail.com"
        passwordTextfield.text = "lalala"
    }
    
    func registerSuccess() {
        //presenter?.router?.showSimpleNativeAlert(with: "Register success", title: "Created")
    }
    
    func registerFailed(messagge: String) {
        presenter?.router?.showSimpleNativeAlert(with: messagge, title: "Register failed")
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        let email = emailTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        if self.presenter?.isDataProvidedValid(email: email, password: password) ?? false {
            self.showActivityIndicator()
            self.presenter?.sendNewRegisterRequest(email: email , password: password)
        }
    }
    
    @IBAction func emailTextfieldDidChange(_ sender: UITextField) {
        handleRegisterButtonState()
    }
    
    @IBAction func passwordTextfieldDidChange(_ sender: UITextField) {
        handleRegisterButtonState()
    }
    
    private func handleRegisterButtonState() {
        if (emailTextfield.text?.isEmpty ?? true) || (passwordTextfield.text?.isEmpty ?? true) {
            registerButton.changeDisabled()
        } else {
            registerButton.changeEnabled()
        }
    }
}

