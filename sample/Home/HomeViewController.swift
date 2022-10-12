//
//  HomeViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func logoutAction(_ sender: Any) {
        FirebaseAuthManager().logoutUser()
    }
    
}
