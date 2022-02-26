//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    struct PhotoCollectionCell: PhotoCollectionViewCellPorotocol {
        var photo: String
    }
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(image)
        self.setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(imageConstraints)
    }

    private lazy var imageConstraints = [
        self.image.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        self.image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        self.image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
    ]
}

extension PhotosCollectionViewCell: PhotoCollectionSetupable {
    func setup(with viewModel: PhotoCollectionViewCellPorotocol) {
        guard let viewModel = viewModel as? PhotoCollectionCell else { return }
        self.image.image = UIImage(named: viewModel.photo)
    }
}
