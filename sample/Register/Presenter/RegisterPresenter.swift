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
    var dataValidator: RegisterDataProtocol?
    
    init(interactor: RegisterInteractorProtocol, view: RegisterViewProtocol, router: RegisterRouterProtocol, dataValidator: RegisterDataProtocol) {
        self.dataValidator = dataValidator
        self.router = router
        self.view = view
        self.interactor = interactor
    }
    
    //Callback for register flow. Called from RegisterInteractor
    func didFinishRegisterRequest(with result: Result<Any, Error>) {
        switch result {
        case .success(_):
            print("Register success")
            view?.registerSuccess()
            router?.showHome()
        case .failure(let failure):
            print("Register failed. Reason: ", failure.localizedDescription)
            //TODO: Also here.
            view?.registerFailed(messagge: failure.localizedDescription)
        }
    }
    
    //Start new register flow.
    func sendNewRegisterRequest(email: String, password: String) {
        interactor?.registerNewUser(withEmail: email, password: password)
    }
    
    //Form data validation function
    public func isDataProvidedValid(email: String, password: String) -> Bool {
        let validator = RegisterDataValidator()
        
        if !validator.isEmailProvidedValid(email) {
            router?.showSimpleNativeAlert(with: "Invalid email", title: "Please provide a valid email")
            return false
        }
        
        if !validator.isPasswordProvidedValid(password) {
            router?.showSimpleNativeAlert(with: "Invalid password", title: "Password must has 6 chars long")
            return false
        }
        
        return validator.isDataProvidedValid(email: email, password: password)
    }
}
