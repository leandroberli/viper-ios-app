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
    var sideMenuView: SideMenuViewController? { get set }
    var homeView: HomeViewController? { get set }
    
    func getUserProfilePhoto(withId: String)
    func didSelectChangePhoto()
}

class EditProfilePresenter: NSObject, EditProfilePresenterProtocol {
    var storageManager: StorageManager?
    var authManager: FirebaseAuthProtocol?
    var view: EditProfileViewController?
    weak var sideMenuView: SideMenuViewController?
    weak var homeView: HomeViewController?
    var router: EditProfileRouterProtocol?
    
    init(storageManager: StorageManager, view: EditProfileViewController, authManager: FirebaseAuthProtocol, router: EditProfileRouterProtocol?) {
        super.init()
        
        self.storageManager = storageManager
        self.view = view
        self.authManager = authManager
        self.router = router
        self.getUserProfilePhoto(withId: self.authManager?.getAuthentincathedUser()?.uid ?? "")
    }
    
    func getUserProfilePhoto(withId: String) {
        self.storageManager?.getImageProfilePhotoUser(withId: withId) { image, error in
            DispatchQueue.main.async {
                self.view?.updatePhotoProfile(image)
            }
        }
    }
    
    func didSelectChangePhoto() {
        self.router?.initImagePickerViewController(delegate: self)
    }
}

//MARK: Image picker delegate
extension EditProfilePresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage else {
            print("Error in: \(#function)")
            return
        }
        self.didReceivedProfileImage(editedImage)
        picker.dismiss(animated: true)
    }
    
    //Received image from picker, upload data and update views.
    func didReceivedProfileImage(_ image: UIImage) {
        startUploadProfileImageProcess(image)
        view?.updatePhotoProfile(image)
        self.homeView?.updateUserProfileImage(image: image)
    }
    
    //Upload to firebase storage.
    func startUploadProfileImageProcess(_ image: UIImage) {
        guard let data = image.pngData(), let user = FirebaseAuthManager().getAuthentincathedUser() else {
            return
        }
        StorageManager().uploadProfilePhotoForUser(withId: user.uid, data: data) { success, error in
            if success {
                //Image uploaded
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

