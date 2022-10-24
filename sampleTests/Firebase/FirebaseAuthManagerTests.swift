//
//  FirebaseAuthManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 05/10/2022.
//

import XCTest
@testable import sample

final class FirebaseAuthManagerTests: XCTestCase {
    
    let existingEmail = "lea@gmail.com"
    let existingPassword = "lalala"
    let fakeEmail = "fake@gmail.com"
    let fakePassword = "123321"
    
    var sut: FirebaseAuthManager!

    override func setUpWithError() throws {
        sut = FirebaseAuthManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSuccessNewUserCreation_shouldResponseUserData() throws {
        let expectation = self.expectation(description: "Expect user data.")
        
        let name = Utils().randomString(length: 8)
        sut.createUser(withEmail: "\(name)@gmail.com", password: "123123") { user, error in
            XCTAssertNotNil(user)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    //This email must already registred.
    func testCreateNewUser_GivenUsedEmail_shouldReturnError() throws {
        let expectation = self.expectation(description: "Expect error when try user creation.")
        
        sut.createUser(withEmail: existingEmail, password: existingPassword) { user, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    //This email must already registred.
    func testSuccessAuthentication_ShouldReturnUserData() throws {
        let exp = self.expectation(description: "Expect user data.")
        sut.authenticateUser(withEmail: existingEmail, password: existingPassword) { user, error in
            exp.fulfill()
            XCTAssertNotNil(user)
        }
        self.wait(for: [exp], timeout: 5)
    }
    
    //This email doesn't exist.
    func testFailedAuthentication_ShouldReturnError() throws {
        let exp = self.expectation(description: "Expect error.")
        sut.authenticateUser(withEmail: fakeEmail, password: fakePassword) { user, error in
            exp.fulfill()
            XCTAssertNotNil(error)
        }
        self.wait(for: [exp], timeout: 5)
    }

}
