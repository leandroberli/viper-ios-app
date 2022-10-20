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
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    var presenter: SideMenuPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUserImage()
        
        let enabled = UserDefaults.standard.bool(forKey: "darkMode")
        darkModeSwitch.isOn = enabled
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userImage.layoutSubviews()
    }
    
    private func setupUserImage() {
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
    
    @IBAction func darkModeAction(_ sender: Any) {
        let enabled = UserDefaults.standard.bool(forKey: "darkMode")
        UserDefaults.standard.set(!enabled, forKey: "darkMode")
        
        darkModeSwitch.isOn = !darkModeSwitch.isOn
        
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark : .light
    }
}
