//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.view.addSubview(collection)
        self.setConstraints()
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .red
        return collection
    }()
    
    private func setConstraints() {
        NSLayoutConstraint.activate(collectionConstraints)
    }
    
    private lazy var collectionConstraints = [
        self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ]
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
