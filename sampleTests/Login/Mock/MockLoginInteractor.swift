//
//  MockLoginInteractor.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample

class MockLoginInteractor: LoginInteractorProtocol {
    var presenter: sample.LoginPresenterProtocol?
    var authManager: sample.FirebaseAuthProtocol?
    
    func authenticateUser(withEmail: String, password: String, completion: @escaping (sample.CustomUser?, Error?) -> Void) {
        if error {
            completion(nil, FirebaseAuthError.unknow)
        } else {
            completion(CustomUser(uid: "", email: ""), nil)
        }
    }
    
    var error = false
}
