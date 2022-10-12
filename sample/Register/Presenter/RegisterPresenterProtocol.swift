//
//  RegisterPresenterProtocol.swift
//  sample
//
//  Created by Leandro Berli on 07/10/2022.
//

import Foundation

protocol RegisterPresenterProtocol {
    var interactor: RegisterInteractorProtocol? { get set }
    var view: RegisterViewProtocol? { get set }
    var router: RegisterRouterProtocol? { get set }
    
    func didFinishRegisterRequest(with resutl: Result<Any,Error>)
    func sendNewRegisterRequest(email: String, password: String)
    func isDataProvidedValid(email: String, password: String) -> Bool
}
