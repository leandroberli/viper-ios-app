//
//  MockRegisterPresenter.swift
//  sampleTests
//
//  Created by Leandro Berli on 06/10/2022.
//

import Foundation

@testable import sample
import XCTest

class MockRegisterPresenter: RegisterPresenterProtocol {
    var interactor: sample.RegisterInteractorProtocol?
    var view: sample.RegisterViewProtocol?
    var router: sample.RegisterRouterProtocol?
    
    var didFinishRegisterRequestWithError = false
    var expectation: XCTestExpectation?
    
    func didFinishRegisterRequest(with resutl: Result<Any, Error>) {
        switch resutl {
        case .success(_):
            didFinishRegisterRequestWithError = false
        case .failure(_):
            didFinishRegisterRequestWithError = true
        }
        expectation?.fulfill()
    }
    
    func sendNewRegisterRequest(email: String, password: String) {
        //TODO
    }
}
