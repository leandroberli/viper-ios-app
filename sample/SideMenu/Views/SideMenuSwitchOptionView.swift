//
//  SideMenuSwitchOptionView.swift
//  sample
//
//  Created by Leandro Berli on 21/10/2022.
//

import UIKit

protocol SideMenuSwitchOptionProtocol: AnyObject {
    func didSelectOption(type: SideMenuOption)
}

enum SideMenuOption: String {
    case darkMode = "Dark mode"
    case hideName = "Hide name"
    case other = "Other"
}

class SideMenuSwitchOptionView: UIView {

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: SideMenuSwitchOptionProtocol?
    
    var option: SideMenuOption = .darkMode {
        didSet {
            optionNameLabel.text = option.rawValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func buttonAction(_ sender: Any) {
        switchControl.isOn = !switchControl.isOn
        delegate?.didSelectOption(type: self.option)
    }
}

extension UIView {
    // MARK: - Custom Functions
    static func instantiateFromNib() -> Self? {
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        }
        
        return instanceFromNib()
    }
}
