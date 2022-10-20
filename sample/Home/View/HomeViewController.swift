//
//  HomeViewController.swift
//  sample
//
//  Created by Leandro Berli on 11/10/2022.
//

import UIKit

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func refreshTable(withPosts: [Post])
    func updateTopBarNameLabel(_ text: String)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var topBarNameLabel: UILabel!
    
    var presenter: HomePresenterProtocol?
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addSwipeForSidemenuGesture()
        showActivityIndicator()
        
        profileButton.backgroundColor = .systemGray4
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.systemMint.cgColor
        
        presenter?.getApods()
        presenter?.getUserInfo()
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
            self.tableView.reloadSections(IndexSet([0]), with: .fade)
        }
    }
    
    //Called from presenter
    func updateUserProfileImage(image: UIImage) {
        profileButton.setBackgroundImage(image, for: .normal)
    }
    
    func updateTopBarNameLabel(_ text: String) {
        topBarNameLabel.text = text
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePostTableViewCell", for: indexPath) as! HomePostTableViewCell
        cell.setupPost(posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectItem(posts[indexPath.row])
    }
}
