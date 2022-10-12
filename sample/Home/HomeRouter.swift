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
        let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
        menu.leftSide = true
        entry?.present(menu, animated: true)
    }
}
