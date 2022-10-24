//
//  EditProfileViewController.swift
//  sample
//
//  Created by Leandro Berli on 17/10/2022.
//

import UIKit

protocol EditProfileViewProtocol: AnyObject {
    func updatePhotoProfile(_ image: UIImage?)
    func updateUserInfo(_ user: CustomUser)
    func showNativeAlertOnView(message: String, title: String)
}

class EditProfileViewController: UIViewController, EditProfileViewProtocol {
    func showNativeAlertOnView(message: String, title: String) {
        self.showSimpleNativeAlert(with: message, title: title)
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextfiled: BaseTextfield!
    @IBOutlet weak var emailTextfield: BaseTextfield!
    @IBOutlet weak var idTextfield: BaseTextfield!
    @IBOutlet weak var changePhotoButton: SimpleButton!
    
    var presenter: EditProfilePresenterProtocol?
    var keyboardHandler: KeyboardNotificationHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.subviews.forEach({ $0.isHidden = true })
        self.showActivityIndicator()
        
        keyboardHandler = KeyboardNotificationHandler(viewController: self)
        keyboardHandler?.suscribeToKeyboardWillShowNotif()
        
        presenter?.getUserProfilePhoto()
        presenter?.getUserData()
    }
    
    func updatePhotoProfile(_ image: UIImage?) {
        self.userImage.tintColor = .systemGray2
        self.userImage.image = image
    }
    
    func updateUserInfo(_ user: CustomUser) {
        self.view.subviews.forEach({ $0.isHidden = false })
        self.removeActivityIndicator()
        nameTextfiled.text = user.name
        idTextfield.text = user.uid
        emailTextfield.text = user.email
    }
    
    @IBAction func changePhotoAction(_ sender: Any) {
        self.presenter?.didSelectChangePhoto()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.presenter?.didSelectSave(name: nameTextfiled.text ?? "" )
    }
}
