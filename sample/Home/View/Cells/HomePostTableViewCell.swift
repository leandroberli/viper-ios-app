//
//  HomePostTableViewCell.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = false
        
        postImage.clipsToBounds = true
        postImage.layer.cornerRadius = 10
        postImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func layoutSubviews() {
        setupShadow()
    }
    
    public func updateShadowPath() {
        mainView.layer.shadowPath = UIBezierPath(roundedRect: mainView.bounds, cornerRadius: 10).cgPath
    }
    
    private func setupShadow() {
        mainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowPath = UIBezierPath(roundedRect: mainView.bounds, cornerRadius: 10).cgPath
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
