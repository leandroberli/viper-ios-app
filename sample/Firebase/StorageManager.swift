//
//  StorageManager.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation
import FirebaseStorage

protocol StorageManagerProtocol {
    func uploadProfilePhotoForUser(withId: String, data: Data, completion: @escaping (Bool, Error?) -> Void)
    func getImageProfilePhotoUser(withId: String, completion: @escaping (UIImage?, Error?) -> Void)
}

class StorageManager: StorageManagerProtocol {
    
    enum FileName: String {
        case userProfilePhoto = "profilePhoto.png"
    }
    
    enum DirectoryPath: String {
        case profilePhotos = "userProfileImages"
    }
    
    let maxSize: Int64 = 10 * 1024 * 1024
    
    // Create/update folder named with userId and create/update photo profile file.
    func uploadProfilePhotoForUser(withId: String, data: Data, completion: @escaping (Bool,Error?) -> Void) {
        //Get root reference
        let ref = Storage.storage().reference()
        //Create new child reference
        let userProfilePhoto = ref.child(withId + "/\(FileName.userProfilePhoto.rawValue)")
        //upload to child reference
        let task = userProfilePhoto.putData(data) { metadata, error in
            guard let _ = metadata else {
                completion(false,error)
                return
            }
            completion(true,error)
        }
        //For progress bar
        task.observe(.progress) { snapshot in
            print(snapshot.progress ?? "")
        }
    }
    
    //Get user profile photo URL.
    func getURLProfilePhotoForUser(withId: String, completion: @escaping (URL?,Error?) -> Void) {
        let ref = Storage.storage().reference().child(withId + "/\(FileName.userProfilePhoto.rawValue)")
        ref.downloadURL { url, error in
            guard let url = url else {
                completion(nil,error)
                return
            }
            completion(url,nil)
        }
    }
    
    //Get user profile UIImage.
    func getImageProfilePhotoUser(withId: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let ref = Storage.storage().reference().child(withId + "/\(FileName.userProfilePhoto.rawValue)")
        ref.getData(maxSize: maxSize) { data, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil,error)
                return
            }
            completion(image,nil)
        }
    }
}
