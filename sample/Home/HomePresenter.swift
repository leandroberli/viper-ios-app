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
    func getUserInfo()
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
    
    func getUserInfo() {
        guard let id = FirebaseAuthManager().getAuthentincathedUser()?.uid else {
            return
        }
        getUserProfileImage(withId: id)
        getUserData(withId: id)
    }
    
    //Get user profile image and update view.
    func getUserProfileImage(withId: String) {
        interactor?.getUserProfileImage(withId: withId) { image in
            DispatchQueue.main.async {
                let finalImage = image ?? UIImage(systemName: "person.fill")!
                self.view?.updateUserProfileImage(image: finalImage)
            }
        }
    }
    
    func getUserData(withId: String) {
        interactor?.getUserData(withId: withId) { user, error in
            if let name = user?.name {
                DispatchQueue.main.async {
                    self.view?.updateTopBarNameLabel("Hi, " + name + "!")
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
