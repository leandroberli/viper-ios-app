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
    func getAuthentincathedUser() -> User? {
        return nil
    }
    
    func authenticateUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        
    }
    
    func logoutUser() {
        
    }
    
    var error: Bool? = false

    func createUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        if error ?? false {
            completion(nil, FirebaseAuthError.emailAlreadyInUse)
        } else {
            completion(nil, nil)
        }
    }
}
