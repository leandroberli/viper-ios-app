//
//  MockStorageManager.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import XCTest
import Foundation
@testable import sample

class MockStorageManager: StorageManagerProtocol {
    
    var mockError = false
    
    func uploadProfilePhotoForUser(withId: String, data: Data, completion: @escaping (Bool, Error?) -> Void) {
        if mockError {
            completion(false,nil)
            return
        }
        completion(true,nil)
    }

    func getImageProfilePhotoUser(withId: String, completion: @escaping (UIImage?, Error?) -> Void) {
        if mockError {
            completion(nil,nil)
            return
        }
        let image = UIImage(systemName: "person")
        completion(image,nil)
    }
}
