//
//  DatabaseManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 18/10/2022.
//

import XCTest
@testable import sample

final class DatabaseManagerTests: XCTestCase {
    
    //Match with user id
    let existingID = "41AyJV24zHRS3xeU0CDsUtQl01S2"
    let fakeID = "1231"
    var sut: DatabaseManager!

    override func setUpWithError() throws {
        sut = DatabaseManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //Create ID or update existing
    func testSaveUserHappyPath() throws {
        let exp = self.expectation(description: "Success task")
        var user = CustomUser(uid: existingID, email: "lea@gmail.com")
        user.name = "From unit testing"
                                   
        sut.saveUser(withId: existingID, data: user) { success in
            exp.fulfill()
            XCTAssertTrue(success)
        }
        
        self.wait(for: [exp], timeout: 5)
    }
    
    //TODO: Sad path.
    func testGetUserData_SuccessFlow() throws {
        let exp = self.expectation(description: "Get CustomUser object.")
        
        sut.getUser(withId: existingID) { user, error in
            exp.fulfill()
            XCTAssertNotNil(user)
        }
        
        self.wait(for: [exp], timeout: 5)
    }
    
    func testGetUserData_WhenDoesntExistInDatabase() throws {
        let exp = self.expectation(description: "Get Error object.")
        sut.getUser(withId: fakeID) { user, error in
            exp.fulfill()
            XCTAssertNotNil(error)
        }
        
        self.wait(for: [exp], timeout: 5)
    }
}
