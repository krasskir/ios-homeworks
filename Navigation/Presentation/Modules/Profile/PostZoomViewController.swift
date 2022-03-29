//
//  PostZoomViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 29.03.2022.
//

import UIKit

class PostZoomViewController: UIViewController {
    
    weak var postCell: PostTableViewCell?
    
    private let cellHeight: CGFloat = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setConstraints()
        self.postTableViewZoom.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.postTableViewZoom.reloadData()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGroupedBackground
        self.view.addSubview(self.postTableViewZoom)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(self.tableViewConstraints)
    }
    
    private lazy var postTableViewZoom: UITableView = {
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
        tableView.register(DefaultHeader.self, forHeaderFooterViewReuseIdentifier: "DefaultHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var tableViewConstraints = [
        self.postTableViewZoom.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.postTableViewZoom.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.postTableViewZoom.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.postTableViewZoom.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ]
    
    private func setHeaderHeight(with cellHeight: CGFloat) -> CGFloat {
        return (self.postTableViewZoom.bounds.size.height - cellHeight) / 2
    }
}

extension PostZoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.backgroundColor = .black
        if let post = postCell {
            return post
        } else {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DefaultHeader")
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.setHeaderHeight(with: cellHeight) >= 0 ? self.setHeaderHeight(with: cellHeight) : 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DefaultHeader")
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.setHeaderHeight(with: cellHeight) >= 0 ? self.setHeaderHeight(with: cellHeight) : 0
    }
}
