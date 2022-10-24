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
    
    func getAuthenticathedUser() -> CustomUser?
}

class SplashInteractor: SplashInteractorProtocol {
    var firebaseAuth: FirebaseAuthProtocol?
    var presenter: SplashPresenterProtocol?
    
    init(firebaseAuth: FirebaseAuthProtocol?) {
        self.firebaseAuth = firebaseAuth
    }
    
    func getAuthenticathedUser() -> CustomUser? {
        return firebaseAuth?.getAuthentincathedUser()
    }    
}
