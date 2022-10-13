//
//  SideMenuViewController.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var presenter: SideMenuPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func editProfileAction(_ sender: Any) {
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        presenter?.didSelectLogOut()
    }
}
