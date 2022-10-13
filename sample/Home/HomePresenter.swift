//
//  HomePresenter.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    var view: HomeViewController? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getApods()
    func getUserProfileImage()
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
    
    //Get table items and update view.
    func getApods() {
        interactor?.getApods { posts, error in
            self.view?.refreshTable(withPosts: posts ?? [])
        }
    }
    
    //Get user profile image and update view.
    func getUserProfileImage() {
        guard let currentUser = FirebaseAuthManager().getAuthentincathedUser() else {
            return
        }
        interactor?.getUserProfileImage(withId: currentUser.uid) { image in
            DispatchQueue.main.async {
                if let img = image {
                    self.view?.updateUserProfileImage(image: img)
                }
            }
        }
    }
    
    func showSideMenu() {
        router?.showSideMenu()
    }
    
    func didSelectItem(_ post: Post) {
        router?.showDetail(withPost: post)
    }
}
