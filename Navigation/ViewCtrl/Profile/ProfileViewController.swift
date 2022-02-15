//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.view.addSubview(self.profileHeaderView)
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Профиль"
        self.navigationItem.backButtonTitle = "Назад"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        profileHeaderView.constraintsSet()
    }
}




