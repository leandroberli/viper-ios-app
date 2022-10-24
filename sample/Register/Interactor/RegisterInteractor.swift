//
//  RegisterInteractor.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation
import FirebaseAuth

class RegisterInteractor: RegisterInteractorProtocol {
    
    var firebaseAuth: FirebaseAuthProtocol?
    var dbManager: DatabaseManagerProtocol?
    var presenter: RegisterPresenterProtocol?
    
    init(authManager: FirebaseAuthProtocol, dbManager: DatabaseManagerProtocol?) {
        self.firebaseAuth = authManager
        self.dbManager = dbManager
    }
    
    //If firebase auth created, save basic data in user collection database.
    func registerNewUser(withEmail: String, password: String) {
        firebaseAuth?.createUser(withEmail: withEmail, password: password) { user, error in
            if let err = error {
                self.presenter?.didFinishRegisterRequest(with: .failure(err))
                return
            }
            self.saveUserInDatabase(user: user)
            self.presenter?.didFinishRegisterRequest(with: .success(user))
        }
    }
    
    func saveUserInDatabase(user: CustomUser?) {
        guard let id = user?.uid, let email = user?.email else {
            return
        }
        let user = CustomUser(uid: id, email: email)
        dbManager?.saveUser(withId: id, data: user) { success in
            
        }
    }
}


