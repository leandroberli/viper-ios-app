//
//  MockRouterEditProfile.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample
import XCTest
import UIKit

class MockRouterEditProfile: EditProfileRouterProtocol {
    
    var entry: sample.EditProfileViewController?
    var showHomeCalled = false
    var popViewCalled = false
    var initPickerCalled = false
    var expectation: XCTestExpectation?
    
    func initImagePickerViewController(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        initPickerCalled = true
        expectation?.fulfill()
    }
    
    func showHomeViewController() {
        showHomeCalled = true
        expectation?.fulfill()
    }
    
    func popEntry() {
        popViewCalled = true
        expectation?.fulfill()
    }
    
    
}
