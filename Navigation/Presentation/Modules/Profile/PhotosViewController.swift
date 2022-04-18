//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var dataSourcePhoto: [String] = []
    
    private var avatarLenght: CGFloat = 1
    private var heightPhoto: NSLayoutConstraint?
    private var widthPhoto: NSLayoutConstraint?
    private var isExpanded: Bool = false
    
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
        NSLayoutConstraint.activate(self.collectionConstraints)
        NSLayoutConstraint.activate(self.darkViewConstraints)
        NSLayoutConstraint.activate(self.cancelButtonConstraints)
    }
    
    private lazy var collectionConstraints = [
        self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
        self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
        self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        self.collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
    ]
    
    private lazy var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.alpha = 0.85
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photo: UIImageView = {
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.contentMode = .scaleAspectFill
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: self.avatarLenght, height: self.avatarLenght)
        return viewPhoto
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "x.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(self.disabledZoomPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var darkViewConstraints = [
        self.darkView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.darkView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
    ]
    
    private lazy var miniPhotoConstraints = [
        self.photo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
        self.photo.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
    ]
    
    private lazy var maxPhotoConstraints = [
        self.photo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.photo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        
        self.darkView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.darkView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    ]
    
    private lazy var cancelButtonConstraints = [
        self.cancelButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5)
    ]
    
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
        self.view.addSubview(self.collection)
        self.view.addSubview(self.darkView)
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.photo)
        self.setConstraints()
        self.setPhotoConstraints()
        
        self.view.insertSubview(self.darkView, aboveSubview: self.collection)
        self.view.insertSubview(self.cancelButton, aboveSubview: self.darkView)
        self.view.insertSubview(self.photo, aboveSubview: self.darkView)
    }
    
    private func itemCollectionSize(for widht: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidht = (widht - 2 * spacing) / 3
        return CGSize(width: neededWidht, height: neededWidht)
    }
    
    private func setPhotoConstraints() {
        self.heightPhoto = self.photo.heightAnchor.constraint(equalToConstant: self.avatarLenght)
        self.widthPhoto = self.photo.widthAnchor.constraint(equalToConstant: self.avatarLenght)

        NSLayoutConstraint.activate( [self.heightPhoto, self.widthPhoto].compactMap({ $0 }) )
        NSLayoutConstraint.activate(self.miniPhotoConstraints)
    }
    
    private func zoomPhoto() {
        NSLayoutConstraint.deactivate(self.miniPhotoConstraints)
        NSLayoutConstraint.activate(self.maxPhotoConstraints)
        
        self.photo.layer.borderWidth = 0
        self.heightPhoto?.constant = UIScreen.main.bounds.width
        self.widthPhoto?.constant = UIScreen.main.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.photo.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancelButton.isHidden.toggle()
            self.isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func unZoomPhoto() {
        NSLayoutConstraint.deactivate(self.maxPhotoConstraints)
        NSLayoutConstraint.activate(self.miniPhotoConstraints)
        
        self.heightPhoto?.constant = self.avatarLenght
        self.widthPhoto?.constant = self.avatarLenght
        
        self.cancelButton.isHidden.toggle()
        
        UIView.animate(withDuration: 0.5) {
            self.photo.layer.cornerRadius = 100 / 2
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.photo.layer.borderWidth = 3.0
            self.isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
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
        let viewModel = PhotosCollectionViewCell.PhotoCollectionCell(id: indexPath.row,
                                                                     photo: photo)
        cell.cellPushDelegate = self
        cell.setup(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        return self.itemCollectionSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    @objc func disabledZoomPhoto(_ sender: UIButton) {
        if isExpanded {
            self.unZoomPhoto()
        }
    }
}

extension PhotosViewController: CellPushDelegate {
    func didTapCell(for id: Int) {
        self.photo.image = UIImage(named: self.dataSourcePhoto[id])
        if !isExpanded {
            self.zoomPhoto()
        }
    }
}
