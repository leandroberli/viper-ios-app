//
//  ApodDetailPresenter.swift
//  sample
//
//  Created by Leandro Berli on 13/10/2022.
//

import Foundation

protocol ApodDetailPresenterProtocol {
    var data: Post? { get set }
    var view: ApodDetailViewController? { get set }
}

class ApodDetailPresenter: ApodDetailPresenterProtocol {
    var data: Post?
    var view: ApodDetailViewController?
    
    init(data: Post?, view: ApodDetailViewController?) {
        self.data = data
        self.view = view
    }
}
