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

class SideMenuRouter: SideMenuRouterProtocol {
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
}
