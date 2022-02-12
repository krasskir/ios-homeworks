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
        
        self.view.addSubview(self.profileHeaderView)
        
        self.view.backgroundColor = .white
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        self.navigationItem.backButtonTitle = "Назад"
        
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame
    }
}
