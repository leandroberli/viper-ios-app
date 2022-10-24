//
//  EditProfilePresenterTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 21/10/2022.
//

import XCTest
@testable import sample

final class EditProfilePresenterTests: XCTestCase {
    
    var sut: EditProfilePresenter!
    var storageManager: MockStorageManager!
    var view: MockEditProfileView!
    var authManager: MockFirebaseAuthManager!
    var router: MockRouterEditProfile!
    var dbManager: MockDatabaseManager!

    override func setUpWithError() throws {
        storageManager = MockStorageManager()
        view = MockEditProfileView()
        authManager = MockFirebaseAuthManager()
        router = MockRouterEditProfile()
        dbManager = MockDatabaseManager()
        sut = EditProfilePresenter(storageManager: storageManager, view: view, authManager: authManager, router: router, databaseManager: dbManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        authManager = nil
        router = nil
        dbManager = nil
    }

    func testGetUserProfilePhotoSuccess_ShouldUpdatePhotoUI() throws {
        let exp = self.expectation(description: "Should call ui function")
        view.expectation = exp
        
        sut.getUserProfilePhoto()
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(view.updatePhotoCalled)
    }
    
    func testFailedUploadProfileImage_ShouldShowAlert() throws {
        let image = UIImage(systemName: "person")!
        let exp = self.expectation(description: "Should call update UI function")
        
        storageManager.mockError = true
        view.failedUploadExp = exp
        sut.didReceivedProfileImage(image)
        
        self.wait(for: [exp], timeout: 1)
        XCTAssertTrue(view.alertShowed)
    }
    
    func testUploadProfileImageSuccess_ShouldUpdatePhotoUI() throws {
        let image = UIImage(systemName: "person")!
        let exp = self.expectation(description: "Should call update UI function")
        view.expectation = exp
        
        sut.didReceivedProfileImage(image)
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(view.updatePhotoCalled)
    }
    
    func testGetUserDataSucced_shouldUpdateDataUI() throws {
        let exp = self.expectation(description: "Expectation: update user UI")
        view.expectation = exp
        sut.getUserData()
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(view.updateUserInfoCalled)
    }
    
    func testSaveUserProcess_shouldUpdateDatabase() throws {
        let exp = self.expectation(description: "")
        dbManager.expectation = exp
        
        sut.saveUserData(name: "Test")
        self.wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(dbManager.saveUserCalled)
    }
    
    func testSaveActionFromRegister_shouldNavToHome() throws {
        let exp = self.expectation(description: "Expect navigate to home.")
        router.expectation = exp
        
        sut.fromRegisterProcess = true
        sut.didSelectSave(name: "test")
        self.wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(router.showHomeCalled)
    }
    
    func testSaveActionFromInApp_shouldPopView() throws {
        let exp = self.expectation(description: "Expect pop view controller.")
        router.expectation = exp
        
        sut.fromRegisterProcess = false
        sut.didSelectSave(name: "test")
        self.wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(router.popViewCalled)
    }
 

}
