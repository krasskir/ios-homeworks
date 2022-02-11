//
//  PostViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 11.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Мой пост"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        self.navigationItem.backButtonTitle = "Назад"
    }

}
