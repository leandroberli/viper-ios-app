//
//  MockRegisterInteractor.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample
import XCTest

class MockRegisterInteractor: RegisterInteractorProtocol {
    func saveUserInDatabase(user: CustomUser?) {
        return
    }
    
    var presenter: sample.RegisterPresenterProtocol?
    
    var firebaseAuth: sample.FirebaseAuthProtocol?
    var registerNewUserCalled = false
    var expectation: XCTestExpectation?
    
    func registerNewUser(withEmail: String, password: String) {
        registerNewUserCalled = true
        self.expectation?.fulfill()
    }
}
