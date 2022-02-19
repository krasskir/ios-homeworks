//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setNavigationBar()
        self.setupView()
        self.setSubViewConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
    }
    
    private func setSubViewConstraints() {
        let profileViewConstraints = [
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(profileViewConstraints)
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "Профиль"
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }
    
}




