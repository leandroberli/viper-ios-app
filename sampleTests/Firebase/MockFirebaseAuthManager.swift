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
    var error: Bool? = false

    func createUser(withEmail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        if error ?? false {
            completion(nil, FirebaseAuthError.failed)
        } else {
            completion(nil, nil)
        }
    }
}
