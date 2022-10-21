//
//  SideMenuPresenter.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation
import SideMenu

protocol SideMenuPresenterProtocol {
    var view: SideMenuViewController? { get set }
    var router: SideMenuRouter? { get set }
    
    func didSelectEditProfile()
    func didSelectLogOut()
    func didSelectOption(_ option: SideMenuOption)
    func didReceivedProfileImage(_ image: UIImage)
}

class SideMenuPresenter: NSObject, SideMenuPresenterProtocol {
    
    weak var view: SideMenuViewController?
    var homeView: HomeViewController?
    var router: SideMenuRouter?
    
    init(view: SideMenuViewController?, router: SideMenuRouter?) {
        self.view = view
        self.router = router
    }
    
    //Get user profile image and update view.
    func getUserProfileImage() {
        guard let user = FirebaseAuthManager().getAuthentincathedUser() else {
            return
        }
        StorageManager().getImageProfilePhotoUser(withId: user.uid) { image, error in
            let newImage = image ?? UIImage(systemName: "person.fill")!
            DispatchQueue.main.async {
                self.view?.updateUserProfileImage(newImage)
            }
        }
    }
    
    func didSelectOption(_ option: SideMenuOption) {
        switch option {
        case .darkMode:
            handleDarkMode()
            return
        case .hideName:
            self.homeView?.topBarNameLabel.isHidden = !(self.homeView?.topBarNameLabel.isHidden ?? false)
            return
        case .other:
            return
        }
    }
    
    private func handleDarkMode() {
        let oldEnableValue = UserDefaults.standard.bool(forKey: "darkMode")
        let newValue = !oldEnableValue
        UserDefaults.standard.set(newValue, forKey: "darkMode")
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = newValue ? .dark : .light
    }
    
    func didSelectEditProfile() {
        //Pass home view for update user photo
        router?.showEditProfile(homeView: self.homeView)
    }
    
    //Not using
    func changeProfilePhoto() {
        router?.initImagePickerViewController(delegate: self)
    }
    
    func didSelectLogOut() {
        startLogoutProcess()
    }
    
    func startLogoutProcess() {
        FirebaseAuthManager().logoutUser()
        router?.startLogoutProcess()
    }
    
    //Received image from picker, upload data and update views.
    func didReceivedProfileImage(_ image: UIImage) {
        startUploadProfileImageProcess(image)
        view?.updateUserProfileImage(image)
        homeView?.updateUserProfileImage(image: image)
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

//MARK: Image picker delegate
extension SideMenuPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage else {
            print("Error in: \(#function)")
            return
        }
        self.didReceivedProfileImage(editedImage)
        picker.dismiss(animated: true)
    }
}
