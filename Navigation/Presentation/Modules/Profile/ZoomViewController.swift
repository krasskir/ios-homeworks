//
//  ZoomViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 30.03.2022.
//

import UIKit

class ZoomViewController: UIViewController {

    private var centerView: UIView!
    private var heightHeaderFooter: CGFloat!

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backViewConstraints = [
        self.backView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        self.backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.backView.heightAnchor.constraint(equalToConstant: self.heightHeaderFooter)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGroupedBackground
        
        self.view.addSubview(self.backView)
    }
    
    func setupView(for view: UIView, with height: CGFloat) {
        self.centerView = view
        self.heightHeaderFooter = height
        
        self.backView.addSubview(self.centerView)
        NSLayoutConstraint.activate(self.backViewConstraints)
    }
}
