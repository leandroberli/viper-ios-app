//
//  HomeViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit
import Kingfisher

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func refreshTable(withPosts: [Post])
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol?
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addSwipeForSidemenuGesture()
        showActivityIndicator()
        presenter?.getApods()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomePostTableViewCell", bundle: nil), forCellReuseIdentifier: "HomePostTableViewCell")
        tableView.backgroundColor = .systemGray6
    }
    
    private func addSwipeForSidemenuGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeForMenu(_:)))
        gesture.direction = .right
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func didSwipeForMenu(_ sender: UISwipeGestureRecognizer) {
        presenter?.showSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        tableView.visibleCells.forEach({
            guard let cell = $0 as? HomePostTableViewCell else {
                return
            }
            cell.updateShadowPath()
        })
    }

    func refreshTable(withPosts: [Post]) {
        self.posts = withPosts
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            self.tableView.reloadData()
        }
    }

    @IBAction func sideMenuAction(_ sender: Any) {
        presenter?.showSideMenu()
    }
}

//MARK: Table view delegates
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePostTableViewCell", for: indexPath) as! HomePostTableViewCell
        cell.titleLabel.text = post.title
        cell.descLabel.text = post.explanation
        cell.postImage.kf.setImage(with: URL(string: post.url))
        return cell
    }
}
