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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomePostTableViewCell", bundle: nil), forCellReuseIdentifier: "HomePostTableViewCell")
        presenter?.getApods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    func refreshTable(withPosts: [Post]) {
        self.posts = withPosts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func logoutAction(_ sender: Any) {
        FirebaseAuthManager().logoutUser()
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
