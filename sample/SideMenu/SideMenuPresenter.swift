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
}

class SideMenuPresenter: SideMenuPresenterProtocol {
    var view: SideMenuViewController?
    var router: SideMenuRouter?
    
    init(view: SideMenuViewController?, router: SideMenuRouter?) {
        self.view = view
        self.router = router
    }
    
    func didSelectEditProfile() {
        //TODO: something.
    }
    
    func didSelectLogOut() {
        startLogoutProcess()
    }
    
    func startLogoutProcess() {
        FirebaseAuthManager().logoutUser()
        router?.startLogoutProcess()
    }
}
