//
//  SideMenuViewController.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editProfileButton: SimpleButton!
    @IBOutlet weak var logoutButton: LogoutButton!
    
    var presenter: SideMenuPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        userImage.layer.borderWidth = 1.5
        userImage.layer.borderColor = UIColor.systemMint.cgColor
        presenter?.getUserProfileImage()
    }
    
    //Update profile photo. Called from presenter
    public func updateUserProfileImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.userImage.image = image
        }
    }

    @IBAction func editProfileAction(_ sender: Any) {
        presenter?.didSelectEditProfile()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        presenter?.didSelectLogOut()
    }
}
