//
//  ApodDetailViewController.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import UIKit
import Kingfisher

class ApodDetailViewController: UIViewController {

    @IBOutlet weak var blurImage: UIImageView!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var presenter: ApodDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.kf.setImage(with: URL(string: presenter?.data?.hdurl ?? ""))
        titleLabel.text = presenter?.data?.title
        descLabel.text = presenter?.data?.explanation
        setupBlurImage()
    }
    
    private func setupBlurImage() {
        blurImage.kf.setImage(with: URL(string: presenter?.data?.hdurl ?? ""))
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = blurImage.bounds
        
        blurImage.addSubview(blurView)
    }
}
