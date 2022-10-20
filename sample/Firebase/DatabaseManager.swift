//
//  DatabaseManager.swift
//  sample
//
//  Created by Leandro Berli on 18/10/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol DatabaseManagerProtocol {
    func saveUser(withId: String, data: CustomUser)
    func getUser(withId: String, completion: @escaping (CustomUser?,Error?) -> Void)
}

class DatabaseManager: DatabaseManagerProtocol {
    
    enum DatabasePaths: String {
        case users = "users"
    }
    
    //Create or update user
    func saveUser(withId: String, data: CustomUser) {
        let db = Firestore.firestore()
        do {
            try db.collection(DatabasePaths.users.rawValue).document(withId).setData(from: data) { error in
                if let err = error {
                    print(err.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
            return
        }
        
    }
    
    func getUser(withId: String, completion: @escaping (CustomUser?,Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection(DatabasePaths.users.rawValue).document(withId).getDocument(as: CustomUser.self) { result in
            switch result {
            case .success(let user):
                completion(user,nil)
            case .failure(let error):
                print("Error getting document: \(error.localizedDescription)")
                completion(nil,error)
            }
        }
    }
}
