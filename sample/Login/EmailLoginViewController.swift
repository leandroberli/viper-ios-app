//
//  EmailLoginViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit

protocol EmailLoginViewProtocol {
    var presenter: LoginPresenterProtocol? { get set }
}

class EmailLoginViewController: UIViewController, EmailLoginViewProtocol {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: LoginButton!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        presenter?.startAuthentication(withEmail: emailTextfield.text ?? "", password: passwordTextfield.text ?? "")
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        presenter?.startRegisterProcess()
    }
    
}
