//
//  SplashViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit

protocol SplashViewProtocol {
    var presenter: SplashPresenterProtocol? { get set }
}

class SplashViewController: UIViewController, SplashViewProtocol {
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        presenter?.startApp()
    }

}
