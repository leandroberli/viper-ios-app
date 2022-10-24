//
//  RegisterPresenterTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 05/10/2022.
//

import XCTest
import FirebaseAuth
@testable import sample

class MockViewRegister: RegisterViewProtocol {
    var presenter: sample.RegisterPresenterProtocol?
    var registerSuccessCalled = false
    var registerFailedCalled = false
    var expectation: XCTestExpectation?
    
    func registerSuccess() {
        registerSuccessCalled = true
        self.expectation?.fulfill()
    }
    
    func registerFailed(messagge: String) {
        registerFailedCalled = true
        self.expectation?.fulfill()
    }
}

class MockRegisterInteractor: RegisterInteractorProtocol {
    func saveUserInDatabase(user: CustomUser?) {
        return
    }
    
    var presenter: sample.RegisterPresenterProtocol?
    
    var firebaseAuth: sample.FirebaseAuthProtocol?
    var registerNewUserCalled = false
    var expectation: XCTestExpectation?
    
    func registerNewUser(withEmail: String, password: String) {
        registerNewUserCalled = true
        self.expectation?.fulfill()
    }
}

final class RegisterPresenterTests: XCTestCase {
    
    var sut: RegisterPresenterProtocol!
    var interactor: MockRegisterInteractor!
    var view: MockViewRegister!
    var router: RegisterRouterProtocol!
    var dataValidator: RegisterDataProtocol!

    override func setUpWithError() throws {
        self.view = MockViewRegister()
        self.interactor = MockRegisterInteractor()
        self.router = RegisterRouter()
        self.dataValidator = RegisterDataValidator()
        
        self.sut = RegisterPresenter(interactor: interactor, view: view, router: router, dataValidator: dataValidator)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.interactor = nil
        self.view = nil
        self.router = nil
        self.dataValidator = nil
    }
    
    func testInvalidDataProvidedInEmail_shouldReturnFalse() throws {
        let valid = sut.isDataProvidedValid(email: "ema", password: "123123")
        XCTAssertFalse(valid)
    }
    
    func testInvalidDataProvidedInPassword_shouldReturnFalse() throws {
        let valid = sut.isDataProvidedValid(email: "ema@gmail.com", password: "123")
        XCTAssertFalse(valid)
    }
    
    func testValidDataProvided_shouldReturnTrue() throws {
        let valid = sut.isDataProvidedValid(email: "lea@gmail.com", password: "lalala")
        XCTAssertTrue(valid)
    }
    
    func testRegisterRequest_WhenSuccess_ShouldCallSuccessView() throws {
        let exp = self.expectation(description: "Register request when success should called success view")
        view.expectation = exp
        
        sut.didFinishRegisterRequest(with: .success([]))
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(view.registerSuccessCalled)
    }
    
    func testRegisterRequest_WhenFailed_ShouldCallFailedView() throws {
        let exp = self.expectation(description: "Register request when success should called success view")
        view.expectation = exp
        
        sut.didFinishRegisterRequest(with: .failure(FirebaseAuthError.emailAlreadyInUse))
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(view.registerFailedCalled)
    }
    
    func testNewRegisterRequest_ShouldCallInteractorProccess() throws {
        let exp = self.expectation(description: "New register request call interactor process")
        interactor.expectation = exp
        
        sut.sendNewRegisterRequest(email: "", password: "")
        self.wait(for: [exp], timeout: 5)
        XCTAssertTrue(interactor.registerNewUserCalled)
    }
}
