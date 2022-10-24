//
//  LoginPresenterTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import XCTest
@testable import sample

final class LoginPresenterTests: XCTestCase {
    
    var sut: LoginPresenter!
    var view: MockLoginView!
    var router: MockLoginRouter!
    var mockInteractor: MockLoginInteractor!

    override func setUpWithError() throws {
        mockInteractor = MockLoginInteractor()
        view = MockLoginView()
        router = MockLoginRouter()
        sut = LoginPresenter(view: view, router: router, interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        view = nil
        router = nil
        sut = nil
    }

    func testStartAuthProccess_WhenGivenValidData_ShouldShowHome() throws {
        let exp = self.expectation(description: "Expect go to home screen")
        router.expectation = exp
        
        sut.startAuthentication(withEmail: "lea@gmail.com", password: "lalala")
        self.wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(router.showHomeCalled)
    }
    
    func testStartAuthProcess_whenInavlidPasswordGiven_shouldShowError() throws {
        let exp = self.expectation(description: "Expecto show alert error.")
        router.expectation = exp
        mockInteractor.error = true
        
        sut.startAuthentication(withEmail: "lea@gmail.com", password: "123123")
        self.wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(router.showAlert)
        
    }

}
