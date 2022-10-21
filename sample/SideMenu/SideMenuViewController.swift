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

    let configurableOptionsArray: [SideMenuOption] = [.darkMode, .hideName, .other]
    var optionsViews: [SideMenuSwitchOptionView]? = []
    var presenter: SideMenuPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUserImage()
        setupSideMenuSwitchOptions()
    }
    
    private func setupSideMenuSwitchOptions() {
        if let stackView = self.view.subviews.first(where: { type(of: $0) == UIStackView.self }) as? UIStackView {
            self.configurableOptionsArray.forEach({
                if let view = SideMenuSwitchOptionView.instantiateFromNib() {
                    view.option = $0
                    view.optionNameLabel.text = $0.rawValue
                    view.delegate = self
                    view.switchControl.isOn = false
                    
                    if $0 == .darkMode {
                        let enabled = UserDefaults.standard.bool(forKey: "darkMode")
                        view.switchControl.isOn = enabled
                    }
                    
                    stackView.addArrangedSubview(view)
                    self.optionsViews?.append(view)
                }
            })
        }
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
}

extension SideMenuViewController: SideMenuSwitchOptionProtocol {

    func didSelectOption(type: SideMenuOption) {
        //Implements new options in SideMenuOption enum and handle interaction in this func.
        presenter?.didSelectOption(type)
    }
    
}
