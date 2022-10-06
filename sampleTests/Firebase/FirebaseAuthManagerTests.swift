//
//  FirebaseAuthManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 05/10/2022.
//

import XCTest
@testable import sample

final class FirebaseAuthManagerTests: XCTestCase {
    
    var sut: FirebaseAuthManager!

    override func setUpWithError() throws {
        sut = FirebaseAuthManager()
    }

    override func tearDownWithError() throws {
        
    }
    
    func testCreateNewUser_Success() throws {
        let expectation = self.expectation(description: "Expect sucessfull user creation")
        
        let name = randomString(length: 8)
        sut.createUser(withEmail: "\(name)@gmail.com", password: "123123") { user, error in
            XCTAssertNotNil(user)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testCreateNewUser_GivenUsedEmail_shouldFail() throws {
        let expectation = self.expectation(description: "Expect failed user creation")
        
        sut.createUser(withEmail: "leandroberli@gmail.com", password: "123123") { user, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }

}
