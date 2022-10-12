//
//  RegisterInteractor.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation

class RegisterInteractor: RegisterInteractorProtocol {
    
    var firebaseAuth: FirebaseAuthProtocol?
    var presenter: RegisterPresenterProtocol?
    
    init(authManager: FirebaseAuthProtocol) {
        self.firebaseAuth = authManager
    }
    
    func registerNewUser(withEmail: String, password: String) {
        firebaseAuth?.createUser(withEmail: withEmail, password: password) { user, error in
            if let err = error {
                self.presenter?.didFinishRegisterRequest(with: .failure(err))
                return
            }
            self.presenter?.didFinishRegisterRequest(with: .success(user))
        }
    }
}


