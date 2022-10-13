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
    @IBOutlet weak var profileButton: UIButton!
    
    var presenter: HomePresenterProtocol?
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addSwipeForSidemenuGesture()
        showActivityIndicator()
        
        profileButton.backgroundColor = .black
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.systemMint.cgColor
        
        presenter?.getApods()
        presenter?.getUserProfileImage()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        //This is for update shadow path from cells
        tableView.visibleCells.forEach({
            guard let cell = $0 as? HomePostTableViewCell else {
                return
            }
            cell.updateShadowPath()
        })
    }

    //Refresh data and table. Called from presenter
    func refreshTable(withPosts: [Post]) {
        self.posts = withPosts
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            self.tableView.reloadData()
        }
    }
    
    //Called from presenter
    func updateUserProfileImage(image: UIImage) {
        profileButton.setBackgroundImage(image, for: .normal)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        self.presenter?.didSelectItem(post)
    }
}
