//
//  RegisterViewController.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import UIKit

protocol RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    
    func registerSuccess()
    func registerFailed(messagge: String)
}

class RegisterViewController: UIViewController, RegisterViewProtocol {
    
    var presenter: RegisterPresenterProtocol?
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerSuccess() {
        let alert = UIAlertController(title: "Register success", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func registerFailed(messagge: String) {
        let alert = UIAlertController(title: "Register failed", message: messagge, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.presenter?.sendNewRegisterRequest(email: emailTextfield.text ?? "" , password: "123123")
    }

}

