//
//  SplashPresenter.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import Foundation
import FirebaseAuth

protocol SplashPresenterProtocol {
    var interactor: SplashInteractorProtocol? { get set }
    var view: SplashViewProtocol? { get set }
    var router: SplashRouterProtocol? { get set }
    
    func getAuthenticathedUser() -> User?
    func startApp()
}

class SplashPresenter: SplashPresenterProtocol {
    var router: SplashRouterProtocol?
    var interactor: SplashInteractorProtocol?
    var view: SplashViewProtocol?
    
    init(router: SplashRouterProtocol? = nil, interactor: SplashInteractorProtocol? = nil, view: SplashViewProtocol? = nil) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func startApp() {
        navigateToNextScreenSwitchUserAuthetication()
    }
    
    //Go to home if user is authenticathed or login
    private func navigateToNextScreenSwitchUserAuthetication() {
        if let _ = getAuthenticathedUser() {
            router?.showHomeScreen()
        } else {
            router?.showLoginScreen()
        }
    }
    
    func getAuthenticathedUser() -> User? {
        return self.interactor?.getAuthenticathedUser()
    }
}
