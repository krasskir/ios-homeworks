//
//  LoginHeaderView.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import UIKit

class LoginHeaderView: UIView, UITextFieldDelegate {
    
    weak var delegateButton: ButtonPushDelegate?
    
    private var emailText: String?
    private var passwordText: String?
    
    private let colorSet = UIColor(hex: "#4885CC")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        self.addSubview(logoView)
        self.stackTextViews.addArrangedSubview(emailTextField)
        self.stackTextViews.addArrangedSubview(passwordTextField)
        self.addSubview(stackTextViews)
        self.addSubview(button)
        
        self.constraintsSet()
    }
    
    private func constraintsSet() {
        NSLayoutConstraint.activate(logoViewConstraints)
        NSLayoutConstraint.activate(stackTextViewsConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    private lazy var logoView: UIImageView = {
        let logo = UIImage(named: "logo.png")
        let logoView = UIImageView()
        logoView.clipsToBounds = true
        logoView.frame.size = CGSize(width: 100, height: 100)
        logoView.image = logo
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    private lazy var logoViewConstraints = [
        self.logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.logoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
        self.logoView.heightAnchor.constraint(equalToConstant: 100),
        self.logoView.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    private lazy var stackTextViews: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackTextViewsConstraints = [
        self.stackTextViews.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.stackTextViews.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.stackTextViews.topAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 120),
        self.stackTextViews.heightAnchor.constraint(equalToConstant: 100)
    ]
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10.0
        textField.backgroundColor = .systemGray6
        textField.placeholder = " Email or phone"
        textField.autocapitalizationType = .none
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.tintColor = colorSet
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailTextChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10.0
        textField.backgroundColor = .systemGray6
        textField.placeholder = " Password"
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.returnKeyType = UIReturnKeyType.done
        textField.tintColor = colorSet
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(passwordTextChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let backgroundImage = UIImage(named: "blue_pixel.png")
        button.setTitle("Log in", for: .normal)
        button.setBackgroundImage(backgroundImage?.image(alpha: 1.0), for: .normal)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .selected)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonConstraints = [
        self.button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.button.topAnchor.constraint(equalTo: self.stackTextViews.bottomAnchor, constant: 16),
        self.button.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    @objc private func didTapButton(sender: UIButton) {
        guard emailText != nil && passwordText != nil else { return }
        delegateButton?.didTapButton()
        clearTextField()
    }
    
    private func clearTextField() {
        emailTextField.text = nil
        passwordTextField.text = nil
        emailText = nil
        passwordText = nil
    }

    @objc private func emailTextChange(_ textField: UITextField) {
        if let text = textField.text {
            self.emailText = text
        }
    }

    @objc private func passwordTextChange(_ textField: UITextField) {
        if let text = textField.text {
            self.passwordText = text
        }
    }
}




