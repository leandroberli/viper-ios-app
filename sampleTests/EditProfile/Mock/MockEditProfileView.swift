//
//  MockEditProfileView.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
import XCTest
@testable import sample

class MockEditProfileView: EditProfileViewProtocol {
    func showNativeAlertOnView(message: String, title: String) {
        alertShowed = true
        failedUploadExp?.fulfill()
    }
    
    var failedUploadPhoto = false
    var alertShowed = false
    var updatePhotoCalled = false
    var updateUserInfoCalled = false
    var expectation: XCTestExpectation?
    var failedUploadExp: XCTestExpectation?
    
    func updatePhotoProfile(_ image: UIImage?) {
        updatePhotoCalled = true
        expectation?.fulfill()
    }
    
    func updateUserInfo(_ user: sample.CustomUser) {
        updateUserInfoCalled = true
        expectation?.fulfill()
    }
}
