//
//  GestureViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.02.2022.
//

import UIKit

class GestureViewController: UIViewController {

    private var avatarLenght: CGFloat = 100
    private var heightPhoto: NSLayoutConstraint?
    private var widthPhoto: NSLayoutConstraint?
    
    private var isExpanded: Bool = false
    private var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setPhotoConstraints()
        self.constraintsSet()
        self.setGesture()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.backView)
        self.view.addSubview(self.photo)
        self.view.addSubview(self.cancelButton)
        self.backView.addSubview(self.button)
        self.backView.addSubview(self.fakePhoto)
        self.backView.addSubview(self.nameLable)
        self.backView.addSubview(self.statusLable)
        self.backView.addSubview(self.statusText)
        
        self.view.insertSubview(self.darkView, aboveSubview: self.backView)
        
        self.photo.isUserInteractionEnabled = true
    }
    
    private func setGesture() {
        self.tapGesture.addTarget(self, action: #selector(self.tapGesturePhoto))
        self.photo.addGestureRecognizer(tapGesture)
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.alpha = 0.85
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photo: UIImageView = {
        let photo = UIImage(named: "cat.jpg")
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.image = photo
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: avatarLenght, height: avatarLenght)
        viewPhoto.layer.cornerRadius = viewPhoto.frame.size.width / 2
        viewPhoto.layer.borderColor = UIColor.black.cgColor
        viewPhoto.layer.borderWidth = 3.0
        return viewPhoto
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "x.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(disabledZoomPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var fakePhoto: UIImageView = {
        let photo = UIImage(named: "cat.jpg")
        let viewPhoto = UIImageView()
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        viewPhoto.image = photo
        viewPhoto.clipsToBounds = true
        viewPhoto.frame.size = CGSize(width: avatarLenght, height: avatarLenght)
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
    
    private lazy var backViewConstraints = [
        self.backView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.backView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        self.backView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        self.backView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    ]
    
    private lazy var cancelButtonConstraints = [
        self.cancelButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5)
    ]
    
    private lazy var constraintsPhoto = [
        self.fakePhoto.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16),
        self.fakePhoto.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
        self.fakePhoto.heightAnchor.constraint(equalToConstant: 100),
        self.fakePhoto.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    private lazy var constraintsButton = [
        self.button.topAnchor.constraint(equalTo: self.fakePhoto.bottomAnchor, constant: 16),
        self.button.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
        self.button.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
        self.button.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    private lazy var constraintsNameLable = [
        self.nameLable.topAnchor.constraint(equalTo: self.backView.safeAreaLayoutGuide.topAnchor, constant: 27),
        self.nameLable.leadingAnchor.constraint(equalTo: self.fakePhoto.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusLable = [
        self.statusLable.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -34),
        self.statusLable.leadingAnchor.constraint(equalTo: self.fakePhoto.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusText = [
        self.statusText.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -14),
        self.statusText.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
        self.statusText.leadingAnchor.constraint(equalTo: self.fakePhoto.trailingAnchor, constant: 16),
        self.statusText.heightAnchor.constraint(equalToConstant: 40)
    ]

    
    private func constraintsSet() {
        NSLayoutConstraint.activate(constraintsButton)
        NSLayoutConstraint.activate(constraintsNameLable)
        NSLayoutConstraint.activate(constraintsStatusText)
        NSLayoutConstraint.activate(constraintsStatusLable)
        NSLayoutConstraint.activate(constraintsPhoto)
        NSLayoutConstraint.activate(backViewConstraints)
        NSLayoutConstraint.activate(cancelButtonConstraints)
        NSLayoutConstraint.activate(darkViewConstraints)
    }
    
    private func setPhotoConstraints() {
        self.heightPhoto = self.photo.heightAnchor.constraint(equalToConstant: avatarLenght)
        self.widthPhoto = self.photo.widthAnchor.constraint(equalToConstant: avatarLenght)

        NSLayoutConstraint.activate( [self.heightPhoto, self.widthPhoto].compactMap({ $0 }) )
        NSLayoutConstraint.activate(miniPhotoConstraints)
    }
    
    private func zoomPhoto() {
        NSLayoutConstraint.deactivate(miniPhotoConstraints)
        NSLayoutConstraint.activate(maxPhotoConstraints)
        
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
        NSLayoutConstraint.deactivate(maxPhotoConstraints)
        NSLayoutConstraint.activate(miniPhotoConstraints)
        
        self.heightPhoto?.constant = avatarLenght
        self.widthPhoto?.constant = avatarLenght
        
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
    
    @objc func tapGesturePhoto(_ gusture: UITapGestureRecognizer) {
        guard self.tapGesture === gusture else { return }
        if !isExpanded {
            self.zoomPhoto()
        }
    }
    
    @objc func disabledZoomPhoto(_ sender: UIButton) {
        if isExpanded {
            self.unZoomPhoto()
        }
    }
}
