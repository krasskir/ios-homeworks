//
//  GestureViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class GestureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.constraintsSet()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.button)
        self.view.addSubview(self.photo)
        self.view.addSubview(self.nameLable)
        self.view.addSubview(self.statusLable)
        self.view.addSubview(self.statusText)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.zoomPhoto))
        self.photo.addGestureRecognizer(tapGesture)
    }
    
    private lazy var photo: UIImageView = {
        let photo = UIImage(named: "cat.jpg")
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.image = photo
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: 100, height: 100)
        viewPhoto.layer.cornerRadius = viewPhoto.frame.size.width / 2
        viewPhoto.layer.borderColor = UIColor.black.cgColor
        viewPhoto.layer.borderWidth = 3.0
        return viewPhoto
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
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
        textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var constraintsPhoto = [
        self.photo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
        self.photo.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.photo.heightAnchor.constraint(equalToConstant: 100),
        self.photo.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    private lazy var constraintsButton = [
        self.button.topAnchor.constraint(equalTo: self.photo.bottomAnchor, constant: 16),
        self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.button.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    private lazy var constraintsNameLable = [
        self.nameLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 27),
        self.nameLable.leadingAnchor.constraint(equalTo: self.photo.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusLable = [
        self.statusLable.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -34),
        self.statusLable.leadingAnchor.constraint(equalTo: self.photo.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusText = [
        self.statusText.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -14),
        self.statusText.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.statusText.leadingAnchor.constraint(equalTo: self.photo.trailingAnchor, constant: 16),
        self.statusText.heightAnchor.constraint(equalToConstant: 40)
    ]
    
    private func constraintsSet() {
        NSLayoutConstraint.activate(constraintsButton)
        NSLayoutConstraint.activate(constraintsPhoto)
        NSLayoutConstraint.activate(constraintsNameLable)
        NSLayoutConstraint.activate(constraintsStatusText)
        NSLayoutConstraint.activate(constraintsStatusLable)
    }
    
    @objc func zoomPhoto(_ gusture: UITapGestureRecognizer) {
        
    }
}
