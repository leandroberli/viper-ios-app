//
//  RegisterButton.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation
import UIKit

class RegisterButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blue
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle("Register", for: .normal)
        self.setTitle("Register", for: .highlighted)
        self.setTitle("Register", for: .selected)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.clipsToBounds = true
    }
    
    func changeDisabled() {
        self.backgroundColor = .lightGray
        self.isEnabled = false
    }
    
    func changeEnabled() {
        self.backgroundColor = .blue
        self.isEnabled = true
    }
}
