//
//  MockFirebaseAuthManager.swift
//  sampleTests
//
//  Created by Leandro Berli on 06/10/2022.
//

import Foundation
import FirebaseAuth
@testable import sample

class MockFirebaseAuthManager: FirebaseAuthProtocol {
    
    func getAuthentincathedUser() -> CustomUser? {
        if error ?? false {
            return nil
        } else {
            return CustomUser(uid: "id", email: "mock@email.com")
        }
    }
    
    func authenticateUser(withEmail: String, password: String, completion: @escaping (CustomUser?, Error?) -> Void) {
        
    }
    
    func logoutUser() {
        
    }
    
    var error: Bool? = false

    func createUser(withEmail: String, password: String, completion: @escaping (CustomUser?, Error?) -> Void) {
        if error ?? false {
            completion(nil, FirebaseAuthError.emailAlreadyInUse)
        } else {
            completion(CustomUser(uid: "id", email: "email"), nil)
        }
    }
}
