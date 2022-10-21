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
        setupOptions()
    }
    
    private func setupOptions() {
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
    
    private func handleDarkMode() {
        let enabled = UserDefaults.standard.bool(forKey: "darkMode")
        UserDefaults.standard.set(!enabled, forKey: "darkMode")
        if let view = self.optionsViews?.first(where: { $0.option == .darkMode }) as? SideMenuSwitchOptionView {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = view.switchControl.isOn ? .dark : .light
        }
    }
}

extension SideMenuViewController: SideMenuSwitchOptionProtocol {
    //Implements new options in SideMenuSwitchOptionView enum and handle interaction in this func.
    func didSelectOption(type: SideMenuOption) {
        switch type {
        case .darkMode:
            handleDarkMode()
        case .hideName:
            //Handle hide name
            return
        case .other:
            return
        }
    }
}
