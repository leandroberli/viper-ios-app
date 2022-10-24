//
//  MockLoginRouter.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample
import XCTest

class MockLoginRouter: LoginRouterProtocol {
    func showSimpleNativeAlert(with messagge: String, title: String?) {
        showAlert = true
        expectation?.fulfill()
    }
    
    var entry: sample.EmailLoginViewController?
    
    var showRegisterCalled = false
    var showHomeCalled = false
    var showAlert = false
    var expectation: XCTestExpectation?
    
    func showRegisterFormScreen() {
        showRegisterCalled = true
        expectation?.fulfill()
    }
    
    func showHomeScreen() {
        showHomeCalled = true
        expectation?.fulfill()
    }
    
    
}
