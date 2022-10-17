//
//  StorageManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 17/10/2022.
//

import XCTest
@testable import sample

final class StorageManagerTests: XCTestCase {
    
    var sut: StorageManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = StorageManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUploadUserProfilePhotoSuccess_ShouldReturnTrue() throws {
        let imgData = UIImage(systemName: "person")?.pngData()!
        let userId = "41AyJV24zHRS3xeU0CDsUtQl01S2"
        let expectation = self.expectation(description: "Expect returns true.")
        
        sut.uploadProfilePhotoForUser(withId: userId, data: imgData!) { success, error in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    //TODO: Try simulate error request
    /*func testUploadUserProfilePhotoFailed_ShouldReturnFalse() throws {
        let data = "dummy".data(using: .utf8)
        let userId = "41AyJV24zHRS3xeU0CDsUtQl01S2"
        let expectation = self.expectation(description: "Expect returns false.")
        
        sut.uploadProfilePhotoForUser(withId: userId, data: data!) { success, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }*/
    
    func testGetUserProfileURLSuccess_ShouldReturnURL() throws {
        let userId = "41AyJV24zHRS3xeU0CDsUtQl01S2"
        let exp = self.expectation(description: "Expect return an URL Object.")
        
        sut.getURLProfilePhotoForUser(withId: userId) { url, error in
            XCTAssertNotNil(url)
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 5)
    }

    func testGetUserProfileURLFailed_ShouldReturnError() throws {
        //This ID doesn't exist
        let userId = "41AyJV24zHRSDsUtQl0S2"
        let exp = self.expectation(description: "Expect return an Error.")
        
        sut.getURLProfilePhotoForUser(withId: userId) { url, error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 5)
    }
}
