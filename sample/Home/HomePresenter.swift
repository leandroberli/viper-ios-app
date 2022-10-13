//
//  HomePresenter.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation

protocol HomePresenterProtocol {
    var view: HomeViewController? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getApods()
    func showSideMenu()
    func didSelectItem(_ post: Post)
}

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewController?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    init(view: HomeViewController, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getApods() {
        interactor?.getApods { posts, error in
            self.view?.refreshTable(withPosts: posts ?? [])
        }
    }
    
    func showSideMenu() {
        router?.showSideMenu()
    }
    
    func didSelectItem(_ post: Post) {
        router?.showDetail(withPost: post)
    }
}
