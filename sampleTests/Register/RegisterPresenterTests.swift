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
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}
