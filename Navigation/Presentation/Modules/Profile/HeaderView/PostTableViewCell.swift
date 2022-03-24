//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    struct PostCell: PostViewCellProtocol {
        var title: String
        var author: String
        var image: String
        var description: String
        var views: Int
        var likes: Int
    }
    
    private lazy var author: String = {
        let text = ""
        return text
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titlePost: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.textColor = .black
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var postText: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 14)
        text.textColor = .systemGray
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var subStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var likes: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16)
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var views: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16)
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
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
    
    private func setupView() {
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.backView)
        self.stackView.addSubview(self.titlePost)
        self.stackView.addSubview(self.postImage)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.postText)
        self.stackView.addArrangedSubview(self.subStackView)
        self.subStackView.addArrangedSubview(self.likes)
        self.subStackView.addArrangedSubview(self.views)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(backViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    private lazy var backViewConstraints = [
        self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
    ]
    
    private lazy var titleConstraints = [
        self.titlePost.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
        self.titlePost.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
        self.titlePost.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
    ]
    
    private lazy var imageViewConstraints = [
        self.postImage.topAnchor.constraint(equalTo: self.titlePost.bottomAnchor, constant: 12),
        self.postImage.centerXAnchor.constraint(equalTo: self.backView.centerXAnchor),
        self.postImage.heightAnchor.constraint(equalTo: self.backView.widthAnchor),
        self.postImage.widthAnchor.constraint(equalTo: self.backView.widthAnchor)
    ]

    private lazy var stackViewConstraints = [
        self.stackView.topAnchor.constraint(equalTo: self.postImage.bottomAnchor, constant: 16),
        self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16),
        self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
        self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
    ]
}

extension PostTableViewCell: PostSetupable {
    func setup(with viewModel: PostViewCellProtocol) {
        guard let viewModel = viewModel as? PostCell else { return }
        self.titlePost.text = viewModel.title
        self.postImage.image = UIImage(named: viewModel.image)
        self.postText.text = viewModel.description
        self.likes.text = "Likes: " + String(viewModel.likes)
        self.views.text = "Views: " + String(viewModel.views)
        self.author = viewModel.author
    }
}
