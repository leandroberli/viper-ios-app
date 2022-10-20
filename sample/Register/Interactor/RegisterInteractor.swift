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
    var dbManager: DatabaseManager?
    var presenter: RegisterPresenterProtocol?
    
    init(authManager: FirebaseAuthProtocol, dbManager: DatabaseManager?) {
        self.firebaseAuth = authManager
        self.dbManager = dbManager
    }
    
    //If firebase auth created, save basic data on user collection database.
    func registerNewUser(withEmail: String, password: String) {
        firebaseAuth?.createUser(withEmail: withEmail, password: password) { user, error in
            if let err = error {
                self.presenter?.didFinishRegisterRequest(with: .failure(err))
                return
            }
            guard let user = user else {
                //Handle user nil
                return
            }
            self.saveUserInDatabase(user: user)
            self.presenter?.didFinishRegisterRequest(with: .success(user))
        }
    }
    
    func saveUserInDatabase(user: FirebaseAuth.User?) {
        guard let id = user?.uid, let email = user?.email else {
            return
        }
        let user = CustomUser(uid: id, email: email)
        dbManager?.saveUser(withId: id, data: user)
    }
}


