//
//  Utils.swift
//  sample
//
//  Created by Leandro Berli on 19/10/2022.
//

import Foundation

class Utils {
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
