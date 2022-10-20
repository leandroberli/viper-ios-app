//
//  SplashRouter.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import Foundation
import UIKit

protocol SplashRouterProtocol {
    var entry: UINavigationController? { get }
    
    func showLoginScreen()
    func showHomeScreen()
}

class SplashRouter: SplashRouterProtocol {
    //Entry point is a Navigation controller. It works as main navigation.
    var entry: UINavigationController?
    
    init() {
        //Root view controller for navigation controller.
        let view: SplashViewController = SplashViewController()
        var interactor: SplashInteractorProtocol = SplashInteractor(firebaseAuth: FirebaseAuthManager())
        
        let presenter: SplashPresenterProtocol = SplashPresenter(router: self, interactor: interactor, view: view)
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        let nav = UINavigationController(rootViewController: view)
        self.entry = nav
    }
    
    func showLoginScreen() {
        let router = LoginRouter()
        let view = EmailLoginViewController()
        router.entry = view
        let interactor = LoginInteractor(authManager: FirebaseAuthManager())
        let presenter = LoginPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        entry?.pushViewController(view, animated: false)
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        let interactor = HomeInteractor(httpClient: ApodHTTPClient())
        let router = HomeRouter()
        router.entry = homeViewController
        
        let presenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)
        
        homeViewController.presenter = presenter
        
        entry?.pushViewController(homeViewController, animated: false)
    }
}
