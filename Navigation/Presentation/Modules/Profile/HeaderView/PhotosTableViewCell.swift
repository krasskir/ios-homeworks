//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Kirill Krasavin on 25.02.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    struct PhotoCell: PhotoViewCellPorotocol {
        var photo: [String]
    }
    
    private lazy var stackLable: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var textLable: UILabel = {
        let text = UILabel()
        text.text = "Photo"
        text.font = .systemFont(ofSize: 24.0, weight: .bold)
        text.textColor = .black
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackImage: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var imageA: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame.size = imageSize()
        imageView.layer.cornerRadius = 6.0
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var imageB: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame.size = imageSize()
        imageView.layer.cornerRadius = 6.0
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageC: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame.size = imageSize()
        imageView.layer.cornerRadius = 6.0
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageD: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame.size = imageSize()
        imageView.layer.cornerRadius = 6.0
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.contentView.addSubview(self.stackLable)
        self.stackLable.addArrangedSubview(self.textLable)
        self.stackLable.addArrangedSubview(self.arrowImage)
        self.contentView.addSubview(self.stackImage)
        self.stackImage.addArrangedSubview(self.imageA)
        self.stackImage.addArrangedSubview(self.imageB)
        self.stackImage.addArrangedSubview(self.imageC)
        self.stackImage.addArrangedSubview(self.imageD)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(stacksConstraints)
    }
    
    private func imageSize() -> CGSize {
        let width = self.contentView.frame.width
        let spacing = stackImage.spacing
        let dim = (width - (3 * spacing) - 24) / 4
        return CGSize(width: dim, height: dim)
    }
    
    private func stackImageHeight() -> CGFloat {
        let width = self.contentView.frame.width
        let spacing = stackImage.spacing
        let dim = (width - (3 * spacing) - 24) / 4
        return dim
    }
    
    private lazy var stacksConstraints = [
        self.stackLable.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
        self.stackLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
        self.stackLable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
        
        
        self.stackImage.topAnchor.constraint(equalTo: self.stackLable.bottomAnchor, constant: 12),
        self.stackImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
        self.stackImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
        self.stackImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
        
        self.stackImage.heightAnchor.constraint(equalToConstant: stackImageHeight())
    ]
}

extension PhotosTableViewCell: PhotoSetupable {
    func setup(with viewModel: PhotoViewCellPorotocol) {
        guard let viewModel = viewModel as? PhotoCell else { return }
        self.imageA.image = UIImage(named: viewModel.photo[0])
        self.imageB.image = UIImage(named: viewModel.photo[1])
        self.imageC.image = UIImage(named: viewModel.photo[2])
        self.imageD.image = UIImage(named: viewModel.photo[3])
    }
}
