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
        sut = nil
    }
    
    func testSuccessNewUserCreation_shouldResponseUserData() throws {
        let expectation = self.expectation(description: "Expect user data")
        
        let name = Utils().randomString(length: 8)
        sut.createUser(withEmail: "\(name)@gmail.com", password: "123123") { user, error in
            XCTAssertNotNil(user)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testCreateNewUser_GivenUsedEmail_shouldReturnError() throws {
        let expectation = self.expectation(description: "Expect error when try user creation")
        
        sut.createUser(withEmail: "lea@gmail.com", password: "123123") { user, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }

}
