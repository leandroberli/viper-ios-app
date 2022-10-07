//
//  RegisterPresenter.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation

class RegisterPresenter: RegisterPresenterProtocol {
    var interactor: RegisterInteractorProtocol?
    var view: RegisterViewProtocol?
    var router: RegisterRouterProtocol?
    
    //Callback for register request from interactor
    func didFinishRegisterRequest(with result: Result<Any, Error>) {
        switch result {
        case .success(_):
            print("Register success")
            view?.registerSuccess()
        case .failure(let failure):
            print("Register failed. Reason: ", failure.localizedDescription)
            view?.registerFailed(messagge: failure.localizedDescription)
        }
    }
    
    //Start new register flow
    func sendNewRegisterRequest(email: String, password: String) {
        interactor?.registerNewUser(withEmail: email, password: password)
    }
    
    func showSimpleNativeAlert(message: String?, title: String?) {
        router?.showSimpleNativeAlert(with: message, title: title)
    }
}
