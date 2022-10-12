//
//  LoginInteractor.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import FirebaseAuth

protocol LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol? { get set }
    var authManager: FirebaseAuthProtocol? { get set }
    
    func authenticateUser(withEmail: String, password: String, completion: @escaping (User?,Error?) -> Void)
}

class LoginInteractor: LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol?
    var authManager: FirebaseAuthProtocol?
    
    init(authManager: FirebaseAuthProtocol) {
        self.authManager = authManager
    }
    
    func authenticateUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        print(#function)
        self.authManager?.authenticateUser(withEmail: withEmail, password: password) { user, error in
            if let err = error {
                completion(nil, err)
                return
            }
            completion(user,nil)
        }
    }
}
