//
//  RegisterInteractorProtocol.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation
import FirebaseAuth

protocol RegisterInteractorProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    var firebaseAuth: FirebaseAuthProtocol? { get set }

    func registerNewUser(withEmail: String, password: String)
    func saveUserInDatabase(user: FirebaseAuth.User?)
}
