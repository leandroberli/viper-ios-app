//
//  LoginRouter.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import UIKit

protocol LoginRouterProtocol {
    var entry: EmailLoginViewController? { get set }
    
    func showRegisterFormScreen()
    func showHomeScreen()
}

class LoginRouter: LoginRouterProtocol {
    var entry: EmailLoginViewController?
    
    init() {
        let loginViewController: EmailLoginViewController = EmailLoginViewController()
        var interactor: LoginInteractorProtocol = LoginInteractor(authManager: FirebaseAuthManager())
        let presenter: LoginPresenterProtocol = LoginPresenter(view: loginViewController, router: self, interactor: interactor)
        interactor.presenter = presenter
        loginViewController.presenter = presenter
        
        self.entry = loginViewController
    }
    
    func showRegisterFormScreen() {
        let router = RegisterRouter()
        entry?.navigationController?.pushViewController(router.entry as! RegisterViewController, animated: true)
    }
    
    func showSimpleNativeAlert(with messagge: String?, title: String?) {
        let alert = UIAlertController(title: title, message: messagge, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(action)
        self.entry?.present(alert, animated: true)
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        let interactor = HomeInteractor(httpClient: ApodHTTPClient())
        let router = HomeRouter()
        router.entry = homeViewController
        
        let presenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)
        
        homeViewController.presenter = presenter
        
        entry?.navigationController?.pushViewController(homeViewController, animated: false)
    }
}
