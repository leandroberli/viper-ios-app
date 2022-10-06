//
//  FirebaseAuthManager.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation
import FirebaseAuth

enum FirebaseAuthError: Error {
    case failed
}

protocol FirebaseAuthProtocol {
    func createUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void)
}

class FirebaseAuthManager: FirebaseAuthProtocol {
    
    func createUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if let err = error {
                completion(nil,err)
                return
            }
            if let user = authResult?.user {
                completion(user, nil)
            }
        }
        
    }
    
    
}
