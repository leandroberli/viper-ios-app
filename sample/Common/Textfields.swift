//
//  Textfields.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation
import UIKit

class BaseTextfield: UITextField {
    
    var bottomLine: CALayer?
    let bottomLineHeight = 1.0
    let height = 30.0
    let fontSize = 17.0
    let bottomLineColor = UIColor.black
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        borderStyle = .none
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        
        self.bottomLine = CALayer()
        self.bottomLine?.frame = CGRect(x: 0, y: height - bottomLineHeight, width: self.bounds.width, height: bottomLineHeight)
        self.bottomLine?.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(self.bottomLine!)
    }
}
