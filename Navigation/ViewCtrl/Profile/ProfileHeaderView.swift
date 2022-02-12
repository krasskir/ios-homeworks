//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .lightGray
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(self.button)
        self.addSubview(self.photo)
        self.addSubview(self.nameLable)
        self.addSubview(self.statusLable)
        self.setConstraintsButton()
        self.setConstraintsPhote()
        self.setConstraintsNameLable()
        self.setConstraintsStatusLable()
    }
    
    private lazy var photo: UIImageView = {
        let photo = UIImage(named: "cat.jpg")
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.image = photo
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: imageHeight, height: imageHeight)
        viewPhoto.layer.cornerRadius = viewPhoto.frame.size.width / 2
        viewPhoto.layer.borderColor = UIColor.white.cgColor
        viewPhoto.layer.borderWidth = 3.0
        return viewPhoto
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Милый Котик"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.clipsToBounds = true
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        return lable
    }()
    
    private lazy var statusLable: UILabel = {
        let lable = UILabel()
        lable.text = "Какой же я милый..."
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.clipsToBounds = true
        lable.textColor = .gray
        lable.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return lable
    }()
    
    func setConstraintsPhote() {
        self.photo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.photo.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        self.photo.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
    }
    
    func setConstraintsButton() {
        self.button.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 16).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setConstraintsNameLable() {
        self.nameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
        self.nameLable.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16).isActive = true
    }
    
    func setConstraintsStatusLable() {
        self.statusLable.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -34).isActive = true
        self.statusLable.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16).isActive = true
    }
    
    @objc private func didTapButton() {
        if let status = statusLable.text {
            print("\(status)")
        }
    }
}
