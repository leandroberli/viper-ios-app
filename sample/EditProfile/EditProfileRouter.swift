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
    func showHomeViewController()
    func popEntry()
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
        self.entry?.navigationController?.present(picker, animated: true)
    }
    
    //Called for registration flow.
    func showHomeViewController() {
        let homeView = HomeViewController()
        let router = HomeRouter()
        let interactor = HomeInteractor(httpClient: ApodHTTPClient())
        let presenter = HomePresenter(view: homeView, interactor: interactor, router: router)
        homeView.presenter = presenter
        router.entry = homeView
        self.entry?.navigationController?.pushViewController(homeView, animated: true)
    }
    
    func popEntry() {
        self.entry?.navigationController?.popViewController(animated: true)
    }
}
