//
//  MockDatabaseManager.swift
//  sampleTests
//
//  Created by Leandro Berli on 21/10/2022.
//

import XCTest
import Foundation
@testable import sample

class MockDatabaseManager: DatabaseManagerProtocol {
    func saveUser(withId: String, data: sample.CustomUser, completion: @escaping (Bool) -> Void) {
        saveUserCalled = true
        expectation?.fulfill()
        return
    }
    
    var mockError = false
    var expectation: XCTestExpectation?
    var saveUserCalled = false
    var getUserCalled = false
    
    func getUser(withId: String, completion: @escaping (sample.CustomUser?, Error?) -> Void) {
        completion(CustomUser(uid: "", email: ""), nil)
        expectation?.fulfill()
        return
    }
}
