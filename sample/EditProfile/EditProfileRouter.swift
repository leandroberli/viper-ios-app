//
//  EditProfileRouter.swift
//  sample
//
//  Created by Leandro Berli on 17/10/2022.
//

import Foundation
import UIKit

protocol EditProfileRouterProtocol {
    var entry: EditProfileViewController? { get set }
    
    func initImagePickerViewController(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate)
}

class EditProfileRouter: EditProfileRouterProtocol {

    var entry: EditProfileViewController?
    
    init(){
        let viewController = EditProfileViewController()
        let presenter = EditProfilePresenter(storageManager: StorageManager(), view: viewController, authManager: FirebaseAuthManager(), router: self)
        viewController.presenter = presenter
        self.entry = viewController
    }
    
    func initImagePickerViewController(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.entry?.present(picker, animated: true)
    }
}
