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
    var entry: UINavigationController?
    
    init() {
        let view: SplashViewController = SplashViewController()
        var interactor: SplashInteractorProtocol = SplashInteractor()
        interactor.firebaseAuth = FirebaseAuthManager()
        let presenter: SplashPresenterProtocol = SplashPresenter(router: self, interactor: interactor, view: view)
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        let nav = UINavigationController(rootViewController: view)
        self.entry = nav
    }
    
    func showLoginScreen() {
        let router = LoginRouter()
        //TODO: Clean force unwrap.
        let view = router.entry!
        entry?.pushViewController(view, animated: false)
    }
    
    func showHomeScreen() {
        let homeViewController = HomeViewController()
        let interactor = HomeInteractor(httpClient: ApodHTTPClient())
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)
        
        homeViewController.presenter = presenter
        
        entry?.pushViewController(homeViewController, animated: false)
    }
}
