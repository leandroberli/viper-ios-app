//
//  StorageManager.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation
import FirebaseStorage

protocol StorageManagerProtocol {
    func uploadProfilePhotoForUser(withId: String, data: Data)
}

class StorageManager: StorageManagerProtocol {
    
    enum DirectoryPath: String {
        case profilePhotos = "userProfileImages"
    }
    
    func uploadProfilePhotoForUser(withId: String, data: Data) {
        //Get root reference
        let ref = Storage.storage().reference()
        //Create new child reference
        let userProfilePhoto = ref.child(DirectoryPath.profilePhotos.rawValue + "/\(withId).png")
        //upload to child reference
        let task = userProfilePhoto.putData(data) { metadata, error in
            guard let metadata = metadata else {
                //Error here
                return
            }
            let size = metadata.size
        }
    }
    
    func getURLProfilePhotoForUser(withId: String, completion: @escaping (URL?,Error?) -> Void) {
        let ref = Storage.storage().reference().child(DirectoryPath.profilePhotos.rawValue + "/\(withId).png")
        ref.downloadURL { url, error in
            guard let url = url else {
                completion(nil,error)
                return
            }
            completion(url,nil)
        }
    }
    
    func getImageProfilePhotoUser(withId: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let ref = Storage.storage().reference().child(DirectoryPath.profilePhotos.rawValue + "/\(withId).png")
        ref.getData(maxSize: 10 * 1024 * 1024) { data, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil,error)
                return
            }
            completion(image,nil)
        }
    }
}
