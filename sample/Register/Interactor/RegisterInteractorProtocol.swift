//
//  RegisterInteractorProtocol.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation

protocol RegisterInteractorProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    var firebaseAuth: FirebaseAuthProtocol? { get set }

    func registerNewUser(withEmail: String, password: String)
}
