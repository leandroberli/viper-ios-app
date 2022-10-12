//
//  RegisterViewProtocol.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation

protocol RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    
    func registerSuccess()
    func registerFailed(messagge: String)
}
