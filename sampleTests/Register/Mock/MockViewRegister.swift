//
//  MockViewRegister.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample
import XCTest

class MockViewRegister: RegisterViewProtocol {
    
    var presenter: sample.RegisterPresenterProtocol?
    var registerSuccessCalled = false
    var registerFailedCalled = false
    var expectation: XCTestExpectation?
    
    func registerSuccess() {
        registerSuccessCalled = true
        self.expectation?.fulfill()
    }
    
    func registerFailed(messagge: String) {
        registerFailedCalled = true
        self.expectation?.fulfill()
    }
}
