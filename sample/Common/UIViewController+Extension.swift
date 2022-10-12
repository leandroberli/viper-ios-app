//
//  UIViewController+Extension.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleNativeAlert(with messagge: String?, title: String?) {
        let alert = UIAlertController(title: title, message: messagge, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
