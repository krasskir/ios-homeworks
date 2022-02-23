//
//  LogInViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setNavigationBar()
        self.setupView()
        self.setConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.loginHeaderView)
        self.loginHeaderView.delegateButton = self
    }
    
    private lazy var loginHeaderView: LoginHeaderView = {
        let view = LoginHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginViewConstraints = [
            self.loginHeaderView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.loginHeaderView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.loginHeaderView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.loginHeaderView.heightAnchor.constraint(equalToConstant: 800)
        ]
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var scrollViewConstraints = [
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    
    private func setNavigationBar() {
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setConstraints() {
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(loginViewConstraints)
    }
}

extension LogInViewController: LoginViewHeaderDelegate {
    func didTapButton() {
        let profile = ProfileViewController()
        self.navigationController?.pushViewController(profile, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
