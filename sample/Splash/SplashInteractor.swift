//
//  File.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import Foundation
import FirebaseAuth

protocol SplashInteractorProtocol {
    var presenter: SplashPresenterProtocol? { get set }
    var firebaseAuth: FirebaseAuthProtocol? { get set }
    
    func getAuthenticathedUser() -> User?
}

class SplashInteractor: SplashInteractorProtocol {
    var firebaseAuth: FirebaseAuthProtocol?
    var presenter: SplashPresenterProtocol?
    
    func getAuthenticathedUser() -> User? {
        return firebaseAuth?.getAuthentincathedUser()
    }    
}
