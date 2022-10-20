//
//  RegisterRouter.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation
import UIKit

typealias EntryPoint = RegisterViewProtocol & UIViewController

class RegisterRouter: RegisterRouterProtocol {
    var entry: EntryPoint?
    
    init() {
        let registerView = RegisterViewController()
        var interactor: RegisterInteractorProtocol = RegisterInteractor(authManager: FirebaseAuthManager(), dbManager: DatabaseManager())
        let validator = RegisterDataValidator()
        
        let presenter: RegisterPresenterProtocol = RegisterPresenter(interactor: interactor, view: registerView, router: self, dataValidator: validator)
        
        interactor.presenter = presenter
        registerView.presenter = presenter
        
        self.entry = registerView
    }
    
    func showSimpleNativeAlert(with messagge: String?, title: String?) {
        let alert = UIAlertController(title: title, message: messagge, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(action)
        self.entry?.present(alert, animated: true)
    }
    
    func showHome() {
        let homeViewController = HomeViewController()
        let interactor = HomeInteractor(httpClient: ApodHTTPClient())
        let router = HomeRouter()
        router.entry = homeViewController
        
        let presenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)
        
        homeViewController.presenter = presenter
        
        entry?.navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    func showEditProfile() {
        let router = EditProfileRouter()
        //Get view controller created in router constructor.
        guard let view = router.entry else {
            return
        }
        let presenter = EditProfilePresenter(storageManager: StorageManager(), view: view, authManager: FirebaseAuthManager(), router: router, databaseManager: DatabaseManager())
        //Register flow flag.
        presenter.fromRegisterProcess = true
        view.presenter = presenter
        entry?.navigationController?.pushViewController(view, animated: true)
    }
}
