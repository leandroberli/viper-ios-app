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
        var interactor: RegisterInteractorProtocol = RegisterInteractor(authManager: FirebaseAuthManager())
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
}