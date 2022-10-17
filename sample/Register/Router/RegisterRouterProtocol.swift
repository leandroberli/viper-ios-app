//
//  RegisterRouterProtocol.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import Foundation

protocol RegisterRouterProtocol {
    var entry: EntryPoint? { get }

    func showSimpleNativeAlert(with messagge: String?, title: String?)
    func showHome()
    func showEditProfile()
}
