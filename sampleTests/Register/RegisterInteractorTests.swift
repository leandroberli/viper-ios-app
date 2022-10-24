//
//  RegisterInteractorTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 05/10/2022.
//

import XCTest
import FirebaseAuth
@testable import sample

final class RegisterInteractorTests: XCTestCase {
    
    var sut: RegisterInteractor!
    var presenter: MockRegisterPresenter!
    var fbManager: MockFirebaseAuthManager!
    var dbManager: MockDatabaseManager!

    override func setUpWithError() throws {
        fbManager = MockFirebaseAuthManager()
        dbManager = MockDatabaseManager()
        sut = RegisterInteractor(authManager: fbManager, dbManager: dbManager)
        presenter = MockRegisterPresenter()
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
        fbManager = nil
        dbManager = nil
    }
    
    func testRegisterWithError_ShouldThrowPresenterError() throws {
        let myExpectation = self.expectation(description: "Expect error handle in presenter")
        
        fbManager.error = true
        presenter.expectation = myExpectation
        sut.registerNewUser(withEmail: "lea@gmail.com", password: "lalala")
        
        self.wait(for: [myExpectation], timeout: 5)
        
        XCTAssertTrue(presenter.didFinishRegisterRequestWithError)
        
    }
    
    func testRegisterSucess_ShouldSaveInDatabase() throws {
        let myExpectation = self.expectation(description: "Expect new user registred saved in database")
        dbManager.expectation = myExpectation
        
        sut.registerNewUser(withEmail: "123@gmail.com", password: "lalala")
        
        self.wait(for: [myExpectation], timeout: 5)
        
        XCTAssertTrue(dbManager.saveUserCalled)
    }
    

}
