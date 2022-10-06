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
    static func start() -> RegisterRouter
}

class RegisterRouter: RegisterRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> RegisterRouter {
        let router = RegisterRouter()
        
        let registerView = RegisterViewController()
        var interactor: RegisterInteractorProtocol = RegisterInteractor(authManager: FirebaseAuthManager())
        var presenter: RegisterPresenterProtocol = RegisterPresenter()
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = registerView
        interactor.presenter = presenter
        registerView.presenter = presenter
        
        router.entry = registerView as? EntryPoint
        return router
        
    }
}
