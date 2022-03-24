//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var dataSourcePhoto: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourcePhoto = testPhotoArray
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Фото галерея"
        self.view.addSubview(collection)
        self.setConstraints()
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    private func setConstraints() {
        NSLayoutConstraint.activate(collectionConstraints)
    }
    
    private lazy var collectionConstraints = [
        self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
        self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
        self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        self.collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
    ]
    
    private func itemCollectionSize(for widht: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidht = (widht - 2 * spacing) / 3
        return CGSize(width: neededWidht, height: neededWidht)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourcePhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let photo = self.dataSourcePhoto[indexPath.row]
        let viewModel = PhotosCollectionViewCell.PhotoCollectionCell(photo: photo)
        cell.setup(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        return self.itemCollectionSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
