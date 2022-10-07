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
    @IBOutlet weak var registerButton: UIButton!
    
    var presenter: RegisterPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerSuccess() {
        presenter?.showSimpleNativeAlert(message: "Register success", title: "Created")
    }
    
    func registerFailed(messagge: String) {
        presenter?.showSimpleNativeAlert(message: messagge, title: "Register failed")
    }
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.presenter?.sendNewRegisterRequest(email: emailTextfield.text ?? "" , password: "123123")
    }
}

