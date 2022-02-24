//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var dataSource: [Post] = []

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = testPostArray
        self.hideKeyboardWhenTappedAround()
        self.setupView()
        self.setConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(profileHeaderView)
        self.view.addSubview(postTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(profileConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var profileConstraints = [
        self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.profileHeaderView.heightAnchor.constraint(equalToConstant: 230)
    ]
    
    private lazy var tableViewConstraints = [
        self.postTableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor),
        self.postTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.postTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.postTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ]
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        var post = self.dataSource[indexPath.row ]
        let viewModel = PostTableViewCell.ViewModel(title: post.title,
                                                    author: post.author,
                                                    image: post.image,
                                                    description: post.discription,
                                                    views: post.views,
                                                    likes: post.likes)
        cell.setup(with: viewModel)
        cell.backgroundColor = .white
        return cell
    }
}



