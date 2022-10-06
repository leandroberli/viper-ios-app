//
//  RegisterPresenterTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 05/10/2022.
//

import XCTest
@testable import sample

final class RegisterPresenterTests: XCTestCase {
    
    var sut: RegisterPresenterProtocol!

    override func setUpWithError() throws {
        sut = RegisterPresenter()
        //sut.interactor =
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
