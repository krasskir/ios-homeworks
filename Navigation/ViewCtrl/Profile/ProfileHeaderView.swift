//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let imageHeight: CGFloat = 100
    private var currentStatus: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(self.button)
        self.addSubview(self.photo)
        self.addSubview(self.nameLable)
        self.addSubview(self.statusLable)
        self.addSubview(self.statusText)
    }
    
    private lazy var photo: UIImageView = {
        let photo = UIImage(named: "cat.jpg")
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.image = photo
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: imageHeight, height: imageHeight)
        viewPhoto.layer.cornerRadius = viewPhoto.frame.size.width / 2
        viewPhoto.layer.borderColor = UIColor.black.cgColor
        viewPhoto.layer.borderWidth = 3.0
        return viewPhoto
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Установить статус", for: .normal)
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
        lable.text = ""
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.clipsToBounds = true
        lable.textColor = .gray
        lable.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return lable
    }()
    
    private lazy var statusText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.backgroundColor = .white
        textField.placeholder = "Введите свой статус"
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.textAlignment = .center
        textField.returnKeyType = UIReturnKeyType.done
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    private func setConstraintsPhote() {
        self.photo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.photo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.photo.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        self.photo.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
    }
    
    private func setConstraintsButton() {
        self.button.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 50).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setConstraintsNameLable() {
        self.nameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
        self.nameLable.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16).isActive = true
    }
    
    private func setConstraintsStatusLable() {
        self.statusLable.bottomAnchor.constraint(equalTo: statusText.topAnchor, constant: -10).isActive = true
        self.statusLable.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16).isActive = true
    }
    
    private func setConstraintsStatusText() {
        self.statusText.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16).isActive = true
        self.statusText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.statusText.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16).isActive = true
        self.statusText.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func constraintsSet() {
        self.setConstraintsButton()
        self.setConstraintsPhote()
        self.setConstraintsNameLable()
        self.setConstraintsStatusLable()
        self.setConstraintsStatusText()
    }
    
    @objc private func didTapButton(sender: UIButton) {
        statusLable.text = currentStatus
        animateView(sender)
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text, textField.text != currentStatus {
            currentStatus = text
        }
    }

    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform =  CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
}
