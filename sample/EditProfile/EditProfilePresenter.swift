//
//  EditProfilePresenter.swift
//  sample
//
//  Created by Leandro Berli on 17/10/2022.
//

import Foundation
import UIKit

protocol EditProfilePresenterProtocol {
    var view: EditProfileViewController? { get set }
    var storageManager: StorageManager? { get set }
    var authManager: FirebaseAuthProtocol? { get set }
    var router: EditProfileRouterProtocol? { get set }
    var homeView: HomeViewController? { get set }
    
    func getUserProfilePhoto()
    func didSelectChangePhoto()
    func didSelectSave(name: String)
    func saveUserData(name: String)
    func getUserData()
}

//TODO: Create interactor.
class EditProfilePresenter: NSObject, EditProfilePresenterProtocol {
    var databaseManager: DatabaseManager?
    var storageManager: StorageManager?
    var authManager: FirebaseAuthProtocol?
    weak var view: EditProfileViewController?
    weak var homeView: HomeViewController?
    var router: EditProfileRouterProtocol?
    var fromRegisterProcess = false
    
    init(storageManager: StorageManager, view: EditProfileViewController, authManager: FirebaseAuthProtocol, router: EditProfileRouterProtocol?, databaseManager: DatabaseManager) {
        super.init()
        
        self.databaseManager = databaseManager
        self.storageManager = storageManager
        self.view = view
        self.authManager = authManager
        self.router = router
    }
    
    func getUserProfilePhoto() {
        let withId = self.authManager?.getAuthentincathedUser()?.uid ?? ""
        storageManager?.getImageProfilePhotoUser(withId: withId) { image, error in
            DispatchQueue.main.async {
                self.view?.updatePhotoProfile(image)
            }
        }
    }
    
    func didSelectChangePhoto() {
        self.router?.initImagePickerViewController(delegate: self)
    }
    
    func didSelectSave(name: String) {
        saveUserData(name: name)
        if !fromRegisterProcess {
            router?.popEntry()
        } else {
            router?.showHomeViewController()
        }
    }
    
    //Save/update user in database.
    func saveUserData(name: String) {
        guard let user = authManager?.getAuthentincathedUser(),
              let email = user.email else {
            return
        }
        var customUser = CustomUser(uid: user.uid, email: email)
        customUser.name = name.isEmpty ? nil : name
        homeView?.updateTopBarNameLabel("Hi, " + (customUser.name ?? "") + "!")
        databaseManager?.saveUser(withId: customUser.uid, data: customUser)
    }
    
    //Get user data and update form
    func getUserData() {
        guard let userId = authManager?.getAuthentincathedUser()?.uid else {
            return
        }
        databaseManager?.getUser(withId: userId) { user, error in
            if let u = user {
                DispatchQueue.main.async {
                    self.view?.updateUserInfo(u)
                }
            }
        }
    }
}

//MARK: Image picker delegate
extension EditProfilePresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage else {
            print("Error in: \(#function)")
            return
        }
        didReceivedProfileImage(editedImage)
        picker.dismiss(animated: true)
    }
    
    //Received image from picker, upload data and update views.
    func didReceivedProfileImage(_ image: UIImage) {
        startUploadProfileImageProcess(image)
        view?.updatePhotoProfile(image)
        homeView?.updateUserProfileImage(image: image)
    }
    
    //Upload to firebase storage.
    func startUploadProfileImageProcess(_ image: UIImage) {
        guard let data = image.pngData(), let user = authManager?.getAuthentincathedUser() else {
            return
        }
        storageManager?.uploadProfilePhotoForUser(withId: user.uid, data: data) { success, error in
            if success {
                print("User profile photo uploaded")
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

