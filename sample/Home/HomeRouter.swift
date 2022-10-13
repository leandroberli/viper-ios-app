//
//  HomeRouter.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import SideMenu

protocol HomeRouterProtocol {
    var entry: HomeViewController? { get set }
    func showSideMenu()
}

class HomeRouter: HomeRouterProtocol {
    var entry: HomeViewController?
    
    func showSideMenu() {
        let vc = SideMenuViewController()
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        let router = SideMenuRouter(entry: vc)
        
        let presenter = SideMenuPresenter(view: vc, router: router)
        vc.presenter = presenter
        
        entry?.present(menu, animated: true)
    }
}
