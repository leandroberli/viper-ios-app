//
//  EditProfileViewController.swift
//  sample
//
//  Created by Leandro Berli on 17/10/2022.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextfiled: BaseTextfield!
    @IBOutlet weak var changePhotoButton: SimpleButton!
    
    var presenter: EditProfilePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getUserProfilePhoto()
    }
    
    func updatePhotoProfile(_ image: UIImage?) {
        self.userImage.image = image
    }


    @IBAction func changePhotoAction(_ sender: Any) {
        self.presenter?.didSelectChangePhoto()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.presenter?.didSelectSave()
    }
}
