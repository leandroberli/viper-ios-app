//
//  HomeInteractor.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import UIKit

protocol HomeInteractorProtocol {
    var httpClient: ApodHTTPClientProtocol? { get set }
    
    func getApods(completion: @escaping (([Post]?, Error?) -> Void))
    func getUserProfileImage(withId: String, completion: @escaping (UIImage?) -> Void)
}

class HomeInteractor: HomeInteractorProtocol {
    var httpClient: ApodHTTPClientProtocol?
    
    init(httpClient: ApodHTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getApods(completion: @escaping (([Post]?, Error?) -> Void)) {
        httpClient?.getApods { posts, error in
            if let err = error {
                print(err.localizedDescription)
                completion(nil,err)
                return
            }
            completion(posts,nil)
        }
    }
    
    func getUserProfileImage(withId: String, completion: @escaping (UIImage?) -> Void) {
        StorageManager().getImageProfilePhotoUser(withId: withId) { image, error in
            completion(image)
        }
    }
}
