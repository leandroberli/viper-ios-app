//
//  RegisterButton.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation
import UIKit

//MARK: Base form button
class BaseFormButton: UIButton {
    let enabledBackgroundColor = UIColor.systemMint
    let disabledBackgroundColor = UIColor.lightGray
    let height = 40.0
    let fontSize = 20.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        self.layer.cornerRadius = height / 2
        self.backgroundColor = UIColor.systemMint
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        self.clipsToBounds = true
    }
    
    func changeDisabled() {
        self.backgroundColor = disabledBackgroundColor
        self.isEnabled = false
    }
    
    func changeEnabled() {
        self.backgroundColor = enabledBackgroundColor
        self.isEnabled = true
    }
}


//MARK: Register button
class RegisterButton: BaseFormButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitle("Register", for: .normal)
        self.setTitle("Register", for: .highlighted)
        self.setTitle("Register", for: .selected)
    }
}

//MARK: Login button
class LoginButton: BaseFormButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitle("Login", for: .normal)
        self.setTitle("Login", for: .highlighted)
        self.setTitle("Login", for: .selected)
    }
}

//MARK: Logout button
class LogoutButton: UIButton {
    let color = UIColor.red
    let fontSize = 14.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.setTitle("Log out", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
    }
}

//MARK: Simple button
class SimpleButton: UIButton {
    
    var fontSize = 14.0
    var titleColor = UIColor.black
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.setTitleColor(titleColor, for: .normal)
    }
}
