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

    override func setUpWithError() throws {
        fbManager = MockFirebaseAuthManager()
        sut = RegisterInteractor(authManager: fbManager)
        presenter = MockRegisterPresenter()
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
        fbManager = nil
    }
    
    func testRegisterWithError_ShouldThrowPresenterError() throws {
        let myExpectation = self.expectation(description: "Expect error handle in presenter")
        
        fbManager.error = true
        presenter.expectation = myExpectation
        sut.registerNewUser(withEmail: "leandroberli@gmail.com", password: "lalala")
        
        self.wait(for: [myExpectation], timeout: 5)
        
        XCTAssertTrue(presenter.didFinishRegisterRequestWithError)
    }
    
    func testRegisterSuccessFlow_ShouldThrowPresenterSuccess() throws {
        let myExpectation = self.expectation(description: "Expect success handle in presenter")
        presenter.expectation = myExpectation
        sut.registerNewUser(withEmail: "leandroberli@gmail.com", password: "lalala")
        self.wait(for: [myExpectation], timeout: 5)
        
        XCTAssertFalse(presenter.didFinishRegisterRequestWithError)
    }

}
