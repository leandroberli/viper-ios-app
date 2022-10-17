//
//  LoginPresenter.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation

protocol LoginPresenterProtocol {
    var interactor: LoginInteractorProtocol? { get set }
    var view: EmailLoginViewProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func startRegisterProcess()
    func startAuthentication(withEmail: String, password: String)
    func didAuthenticateRequestFailed(error: String)
    func didAuthenticateRequestSuccess()
    func showHomeScreen()
}

class LoginPresenter: LoginPresenterProtocol {
    var view: EmailLoginViewProtocol?
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorProtocol?
    
    init(view: EmailLoginViewProtocol? = nil, router: LoginRouterProtocol? = nil, interactor: LoginInteractorProtocol? = nil) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func startRegisterProcess() {
        self.router?.showRegisterFormScreen()
    }
    
    func startAuthentication(withEmail: String, password: String) {
        interactor?.authenticateUser(withEmail: withEmail, password: password) { user, error in
            if let err = error {
                self.didAuthenticateRequestFailed(error: err.localizedDescription)
                return
            }
            self.didAuthenticateRequestSuccess()
        }
    }
    
    func didAuthenticateRequestFailed(error: String) {
        print(error)
        self.view?.didReceivedAuthError()
        self.router?.entry?.showSimpleNativeAlert(with: error, title: "Login error")
    }
    
    func didAuthenticateRequestSuccess() {
        self.showHomeScreen()
    }
    
    func showHomeScreen() {
        self.router?.showHomeScreen()
    }
}
