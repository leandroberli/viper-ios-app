//
//  SideMenuRouter.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation
import SideMenu

protocol SideMenuRouterProtocol {
    var entry: SideMenuViewController? { get set }
    
    func startLogoutProcess()
}

class SideMenuRouter: NSObject, SideMenuRouterProtocol {
    var entry: SideMenuViewController?
    
    init(entry: SideMenuViewController?) {
        self.entry = entry
    }
    
    func startLogoutProcess() {
        guard let window = entry?.view.window else {
            return
        }
        let router = SplashRouter()
        window.rootViewController = router.entry
        window.makeKeyAndVisible()
    }
    
    func initImagePickerViewController(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.entry?.present(picker, animated: true)
    }
    
    func showEditProfile(homeView: HomeViewController?) {
        let router = EditProfileRouter()
        guard let entry = router.entry else {
            return
        }
        entry.presenter?.homeView = homeView
        self.entry?.navigationController?.pushViewController(entry, animated: true)
    }
}
