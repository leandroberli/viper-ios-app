//
//  RegisterRouter.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation
import UIKit

typealias EntryPoint = RegisterViewProtocol & UIViewController

protocol RegisterRouterProtocol {
    var entry: EntryPoint? { get }

    func showSimpleNativeAlert(with messagge: String?, title: String?)
}

class RegisterRouter: RegisterRouterProtocol {
    var entry: EntryPoint?
    
    init() {
        let registerView = RegisterViewController()
        var interactor: RegisterInteractorProtocol = RegisterInteractor(authManager: FirebaseAuthManager())
        var presenter: RegisterPresenterProtocol = RegisterPresenter()
        
        presenter.router = self
        presenter.interactor = interactor
        presenter.view = registerView
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
