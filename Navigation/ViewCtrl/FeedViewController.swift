//
//  FeedViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let firstPost: Post = Post(title: "Какой-то пост")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setNavigationBar()
        self.view.addSubview(self.feedStack)
        self.feedStack.addArrangedSubview(firstButton)
        self.feedStack.addArrangedSubview(secondButton)
        self.setConstraintsFeedStack()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    private lazy var feedStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Первая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdTapButton), for: .touchDown)
        button.addTarget(self, action: #selector(dragExitButton), for: .touchDragExit)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Вторая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdTapButton), for: .touchDown)
        button.addTarget(self, action: #selector(dragExitButton), for: .touchDragExit)
        return button
    }()

    private func setConstraintsFeedStack() {
        let constraintsFeedStack = [
            self.feedStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.feedStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.feedStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.feedStack.heightAnchor.constraint(equalToConstant: 110)
        ]
        NSLayoutConstraint.activate(constraintsFeedStack)
    }
    
    @objc private func didTapButton(sender: UIButton) {
        animateTap(sender, 0.85)
        let postView = PostViewController()
        postView.navigationItem.title = firstPost.title
        self.navigationController?.pushViewController(postView, animated: true)
    }
    
    @objc private func holdTapButton(sender: UIButton) {
        animateHoldRelease(sender, 0.95, 0.85)
    }
    
    @objc private func dragExitButton(sender: UIButton) {
        animateHoldRelease(sender, 1.0, 0.85)
    }
    
}
