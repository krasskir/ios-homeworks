//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let cellHeight: CGFloat = 600
    
    private var dataSourcePost: [Post] = []
    private var dataSourcePhoto: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourcePost = testPostArray
        self.dataSourcePhoto = Array(testPhotoArray.prefix(4))
        self.hideKeyboardWhenTappedAround()
        self.setNavigationBar()
        self.setupView()
        self.setConstraints()
    }

    private func setupView() {
        self.view.backgroundColor = .systemGroupedBackground
        self.view.addSubview(self.postTableView)
    }
    
    private func setNavigationBar() {
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(self.tableViewConstraints)
    }
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(DefaultHeader.self, forHeaderFooterViewReuseIdentifier: "DefaultHeader")
        tableView.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: "ProfileHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var tableViewConstraints = [
        self.postTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.postTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.postTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.postTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ]
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.dataSourcePost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let photoArray = self.dataSourcePhoto
            let viewModel = PhotosTableViewCell.PhotoTableCell(photo: photoArray)
            cell.delegateButton = self
            cell.setup(with: viewModel)
            cell.backgroundColor = .white
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            var post = self.dataSourcePost[indexPath.row]
            let viewModel = PostTableViewCell.PostCell(id: indexPath.row, title: post.title,
                                                        author: post.author,
                                                        image: post.image,
                                                        description: post.discription,
                                                        views: post.views,
                                                        likes: post.likes)
            cell.setup(with: viewModel)
            cell.delegateButton = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeader") as? ProfileHeader else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DefaultHeader")
            return view
        }
        if section == 0 {
            return view
        } else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DefaultHeader")
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 230 : 10
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        var configuration: UISwipeActionsConfiguration? = nil
        if indexPath.section == 1 {
            let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
                completion(true)
            }
            self.dataSourcePost.remove(at: indexPath.row)
            self.postTableView.deleteRows(at: [indexPath], with: .automatic)
            configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        }
        return configuration
    }
}

extension ProfileViewController: ButtonPushDelegate {
    func didTapButtonEnter() {
        let photos = PhotosViewController()
        self.navigationController?.pushViewController(photos, animated: true)
    }
}

extension ProfileViewController: CellPushDelegate {
    func didTapCell(for id: Int) {
        let height = self.cellHeight
        let view = (self.postTableView.cellForRow(at: IndexPath(row: id, section: 1)) as? PostTableViewCell)?.contentView.snapshotView(afterScreenUpdates: true)
        let post = ZoomViewController()
        if view != nil {
            post.setupView(for: view!, with: height)
            self.present(post, animated: true, completion: nil)
        }
    }
}
