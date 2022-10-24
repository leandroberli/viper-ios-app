//
//  FirebaseAuthManager.swift
//  sample
//
//  Created by Leandro Berli on 05/10/2022.
//

import Foundation
import FirebaseAuth

enum FirebaseAuthError: String, Equatable, Error, LocalizedError {
    case wrongPassword = "ERROR_WRONG_PASSWORD"
    case userNotFound = "ERROR_USER_NOT_FOUND"
    case emailAlreadyInUse = "ERROR_EMAIL_ALREADY_IN_USE"
    case unknow = "ERROR_TOO_MANY_REQUESTS"
    
    public var errorDescription: String? {
        switch self {
        case .wrongPassword:
            return NSLocalizedString("We detect you're entering wrong password", comment: "Comment")
        case .userNotFound:
            return NSLocalizedString("We didn't find that email", comment: "")
        case .unknow:
            return NSLocalizedString("Something went wrong. Try again later", comment: "")
        case .emailAlreadyInUse:
            return NSLocalizedString("That email is already in use", comment: "")
        }
    }
}

protocol FirebaseAuthProtocol {
    func createUser(withEmail: String, password: String, completion: @escaping (CustomUser?, Error?) -> Void)
    func getAuthentincathedUser() -> CustomUser?
    func authenticateUser(withEmail: String, password: String, completion: @escaping (CustomUser?,Error?) -> Void)
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
    func authenticateUser(withEmail: String, password: String, completion: @escaping (CustomUser?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { authData, error in
            if let err = error {
                let error = self.processError(err)
                completion(nil,error)
                return
            }
            let user = self.getCustomUserFrom(firebaseUser: authData?.user)
            completion(user, nil)
        }
    }
    
    //Get current user
    func getAuthentincathedUser() -> CustomUser? {
        if let user = Auth.auth().currentUser {
          return getCustomUserFrom(firebaseUser: user)
        } else {
          return nil
        }
    }
    
    func getCustomUserFrom(firebaseUser: User?) -> CustomUser? {
        guard let id = firebaseUser?.uid, let email = firebaseUser?.email else {
            return nil
        }
        return CustomUser(uid: id, email: email)
    }
    
    func createUser(withEmail: String, password: String, completion: @escaping (CustomUser?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if let err = error {
                completion(nil,err)
                return
            }
            let user = self.getCustomUserFrom(firebaseUser: authResult?.user)
            completion(user, nil)
        }
    }
    
    private func processError(_ error: Error) -> FirebaseAuthError {
        let errorCode = error._userInfo?["FIRAuthErrorUserInfoNameKey"] as! String
        switch errorCode {
        case FirebaseAuthError.wrongPassword.rawValue:
            return FirebaseAuthError.wrongPassword
        case FirebaseAuthError.userNotFound.rawValue:
            return FirebaseAuthError.userNotFound
        default:
            return FirebaseAuthError.unknow
        }
    }
}
