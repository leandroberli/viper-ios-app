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
    func getAuthentincathedUser() -> User?
    func authenticateUser(withEmail: String, password: String, completion: @escaping (User?,Error?) -> Void)
    func logoutUser()
}

class FirebaseAuthManager: FirebaseAuthProtocol {
    
    func logoutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //Login request
    func authenticateUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { authData, error in
            if let err = error {
                completion(nil,err)
                return
            }
            completion(authData?.user, nil)
        }
    }
    
    //Get current user
    func getAuthentincathedUser() -> User? {
        if let user = Auth.auth().currentUser {
          return user
        } else {
          return nil
        }
    }
    
    func createUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if let err = error {
                completion(nil,err)
                return
            }
            completion(authResult?.user, nil)
        }
    }
}
