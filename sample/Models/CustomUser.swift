//
//  CustomUser.swift
//  sample
//
//  Created by Leandro Berli on 18/10/2022.
//

import Foundation

struct CustomUser: Codable {
    var uid: String
    var email: String
    var name: String?
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
