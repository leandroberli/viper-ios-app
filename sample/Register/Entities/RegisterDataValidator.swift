//
//  RegisterDataValidator.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import Foundation

protocol RegisterDataProtocol {
    func isDataProvidedValid(email: String, password: String) -> Bool
    func isEmailProvidedValid(_ email: String) -> Bool
    func isPasswordProvidedValid(_ password: String) -> Bool
}

class RegisterDataValidator: RegisterDataProtocol {
    
    public func isDataProvidedValid(email: String, password: String) -> Bool {
        return isEmailProvidedValid(email) && isPasswordProvidedValid(password)
    }
    
    public func isEmailProvidedValid(_ email: String) -> Bool {
        if !email.contains("@") {
            return false
        }
        return true
    }
    
    public func isPasswordProvidedValid(_ password: String) -> Bool {
        if password.count < 6 {
            return false
        }
        return true
    }
}
