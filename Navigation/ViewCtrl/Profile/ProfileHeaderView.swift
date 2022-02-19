//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private let imageHeight: CGFloat = 100
    private var currentStatus: String?
    private let statusLength = 32

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
        
        self.constraintsSet()
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
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdTapButton), for: .touchDown)
        button.addTarget(self, action: #selector(dragExitButton), for: .touchDragExit)
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
        textField.isHidden = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var constraintsPhoto = [
        self.photo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
        self.photo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        self.photo.heightAnchor.constraint(equalToConstant: imageHeight),
        self.photo.widthAnchor.constraint(equalToConstant: imageHeight)
    ]
    
    private lazy var constraintsButton = [
        self.button.topAnchor.constraint(equalTo: self.photo.bottomAnchor, constant: 16),
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        self.button.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    private lazy var constraintsNameLable = [
        self.nameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
        self.nameLable.leadingAnchor.constraint(equalTo: self.photo.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusLable = [
        self.statusLable.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -34),
        self.statusLable.leadingAnchor.constraint(equalTo: self.photo.trailingAnchor, constant: 16)
    ]
    
    private lazy var constraintsStatusText = [
        self.statusText.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -14),
        self.statusText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
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
    
    @objc private func didTapButton(sender: UIButton) {
        animateTap(sender, 0.85)
        if statusText.isHidden {
            didHideTextField()
        } else {
            willHideTextField()
        }
    }
    
    private func didHideTextField() {
        self.constraintsStatusLable[0].constant = -68
        self.constraintsButton[0].constant = 50
        self.button.setTitle("Установить статус", for: .normal)
        UIView.animate(withDuration: 0.45) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.statusText.isHidden.toggle()
        }
    }
    
    private func willHideTextField() {
        self.statusText.isHidden.toggle()
        self.constraintsButton[0].constant = 16
        self.constraintsStatusLable[0].constant = -34
        self.statusLable.text = currentStatus
        self.statusText.text = ""
        self.currentStatus = nil
        self.button.setTitle("Изменить статус", for: .normal)
        UIView.animate(withDuration: 0.45) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func holdTapButton(sender: UIButton) {
        animateHoldRelease(sender, 0.95, 0.85)
    }
    
    @objc private func dragExitButton(sender: UIButton) {
        animateHoldRelease(sender, 1.0, 0.85)
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text, textField.text != currentStatus, statusText.isHidden == false {
            self.currentStatus = text
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= statusLength
    }
}


