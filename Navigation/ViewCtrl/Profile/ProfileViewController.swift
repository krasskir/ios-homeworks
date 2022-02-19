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
        self.setButtonConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.button)
    }
    
    private func setSubViewConstraints() {
        let profileViewConstraints = [
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ]
        NSLayoutConstraint.activate(profileViewConstraints)
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "Профиль"
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Какая-то непонятная кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdTapButton), for: .touchDown)
        button.addTarget(self, action: #selector(dragExitButton), for: .touchDragExit)
        return button
    }()
    
    private func setButtonConstraints() {
        let buttonConstraints = [
            self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc private func didTapButton(sender: UIButton) {
        animateTap(sender, 0.85)
        print("Ты меня нажал")
    }
    @objc private func holdTapButton(sender: UIButton) {
        animateHoldRelease(sender, 0.95, 0.85)
    }
    @objc private func dragExitButton(sender: UIButton) {
        animateHoldRelease(sender, 1.0, 0.85)
    }
    
}




