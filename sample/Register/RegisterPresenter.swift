//
//  RegisterPresenter.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation

protocol RegisterPresenterProtocol {
    var interactor: RegisterInteractorProtocol? { get set }
    var view: RegisterViewProtocol? { get set }
    var router: RegisterRouterProtocol? { get set }
    
    func didFinishRegisterRequest(with resutl: Result<Any,Error>)
    func sendNewRegisterRequest(email: String, password: String)
}

class RegisterPresenter: RegisterPresenterProtocol {
    var interactor: RegisterInteractorProtocol?
    var view: RegisterViewProtocol?
    var router: RegisterRouterProtocol?
    
    //Do things in the view controller
    func didFinishRegisterRequest(with result: Result<Any, Error>) {
        switch result {
        case .success(let success):
            print("Register success")
            view?.registerSuccess()
        case .failure(let failure):
            print("Register failed. Reason: ", failure.localizedDescription)
            view?.registerFailed(messagge: failure.localizedDescription)
        }
    }
    
    func sendNewRegisterRequest(email: String, password: String) {
        interactor?.registerNewUser(withEmail: email, password: password)
    }
}
