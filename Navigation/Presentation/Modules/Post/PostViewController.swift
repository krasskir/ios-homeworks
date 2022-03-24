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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapBarButton))
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }

    @objc private func didTapBarButton() {
        let infoView = InfoViewController()
        self.present(infoView, animated: true, completion: nil)
    }
}
