//
//  EmailLoginViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit

protocol EmailLoginViewProtocol {
    var presenter: LoginPresenterProtocol? { get set }
    
    func didReceivedAuthError()
}

class EmailLoginViewController: UIViewController, EmailLoginViewProtocol {
   
    @IBOutlet weak var emailTextfield: BaseTextfield!
    @IBOutlet weak var passwordTextfield: BaseTextfield!
    @IBOutlet weak var loginButton: LoginButton!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextfield.text = "lalala"
        emailTextfield.text = "lea@gmail.com"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        self.showActivityIndicator()
        presenter?.startAuthentication(withEmail: emailTextfield.text ?? "", password: passwordTextfield.text ?? "")
    }
    
    func didReceivedAuthError() {
        DispatchQueue.main.async {
            self.removeActivityIndicator()
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        presenter?.startRegisterProcess()
    }
    
}
