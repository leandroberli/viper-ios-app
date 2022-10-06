//
//  RegisterInteractor.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation

protocol RegisterInteractorProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    var firebaseAuth: FirebaseAuthProtocol? { get set }

    func registerNewUser(withEmail: String, password: String)
}

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


