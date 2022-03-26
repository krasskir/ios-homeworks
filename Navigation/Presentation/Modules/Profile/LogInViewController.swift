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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObserverKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setScrollViewOffset(CGPoint(x: 0, y: (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 2))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserverKeyboard()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.loginHeaderView)
        self.loginHeaderView.delegateButtonEnter = self
        self.loginHeaderView.delegateButtonAlert = self
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
        self.loginHeaderView.heightAnchor.constraint(equalToConstant: 780)
    ]
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var scrollViewConstraints = [
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ]
    
    private func setNavigationBar() {
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setConstraints() {
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(loginViewConstraints)
    }
    
    private func setScrollViewOffset(_ offset: CGPoint) {
        self.scrollView.setContentOffset(offset, animated: true)
    }
    
    private func addObserverKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    private func removeObserverKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        self.setScrollViewOffset(CGPoint(x: 0, y: (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 1.45))
    }

    @objc func keyboardWillDisappear(notification: NSNotification) {
        self.setScrollViewOffset(CGPoint(x: 0, y: (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 2))
    }
}

extension LogInViewController: ButtonPushDelegate {
    func didTapButtonEnter() {
        let profile = ProfileViewController()
        self.navigationController?.pushViewController(profile, animated: true)
    }
}

extension LogInViewController: ButtonAlertDelegate {
    func didTapButtonAlert() {
        let alertView = LoginAlertController()
        self.present(alertView, animated: true, completion: nil)
    }
}
