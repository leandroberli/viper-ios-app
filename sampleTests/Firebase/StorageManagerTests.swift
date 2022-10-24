//
//  StorageManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 17/10/2022.
//

import XCTest
@testable import sample

final class StorageManagerTests: XCTestCase {
    
    let existingID = "41AyJV24zHRS3xeU0CDsUtQl01S2"
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
        let imgData = UIImage(systemName: "person.fill")?.pngData()!
        let userId = existingID
        let expectation = self.expectation(description: "Expect returns true.")
        
        sut.uploadProfilePhotoForUser(withId: userId, data: imgData!) { success, error in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetUploadedUserProfilePhotoSuccess() throws {
        let exp = self.expectation(description: "Image data.")
        sut.getImageProfilePhotoUser(withId: existingID) { image, error in
            exp.fulfill()
            XCTAssertNotNil(image)
        }
        self.wait(for: [exp], timeout: 5)
    }
}
