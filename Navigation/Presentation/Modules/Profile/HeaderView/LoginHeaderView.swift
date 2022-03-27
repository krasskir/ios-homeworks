//
//  LoginHeaderView.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import UIKit

class LoginHeaderView: UIView, UITextFieldDelegate {
    
    weak var delegateButtonEnter: ButtonPushDelegate?
    weak var delegateButtonAlert: ButtonAlertDelegate?
    
    private let standartLogin: String = "kkrasavin@yarz.ru"
    private let standertPassword: String = "12345678"
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
        
        self.addSubview(self.logoView)
        self.stackTextViews.addArrangedSubview(self.emailTextField)
        self.stackTextViews.addArrangedSubview(self.passwordTextField)
        self.addSubview(self.stackTextViews)
        self.addSubview(self.button)
        self.addSubview(self.passwordErrorLable)
        self.addSubview(self.emailErrorLable)
        
        self.constraintsSet()
    }
    
    private func constraintsSet() {
        NSLayoutConstraint.activate(self.logoViewConstraints)
        NSLayoutConstraint.activate(self.stackTextViewsConstraints)
        NSLayoutConstraint.activate(self.buttonConstraints)
        NSLayoutConstraint.activate(self.passwordErrorLableConstraints)
        NSLayoutConstraint.activate(self.emailErrorLableConstraints)
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
        textField.placeholder = " Email или номер телефона"
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
        textField.placeholder = " Пароль"
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
        button.setTitle("Войти", for: .normal)
        button.setBackgroundImage(backgroundImage?.image(alpha: 1.0), for: .normal)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .selected)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(backgroundImage?.image(alpha: 0.8), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonConstraints = [
        self.button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.button.topAnchor.constraint(equalTo: self.stackTextViews.bottomAnchor, constant: 16),
        self.button.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    private lazy var passwordErrorLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .systemRed
        lable.font = UIFont.systemFont(ofSize: 10.0)
        lable.text = "Пароль должен быть больше 8 символов"
        lable.isHidden = true
        return lable
    }()
    
    private lazy var passwordErrorLableConstraints = [
        self.passwordErrorLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.passwordErrorLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.passwordErrorLable.topAnchor.constraint(equalTo: self.stackTextViews.bottomAnchor, constant: 2),
        self.passwordErrorLable.heightAnchor.constraint(equalToConstant: 10)
    ]
    
    private lazy var emailErrorLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .systemRed
        lable.font = UIFont.systemFont(ofSize: 10.0)
        lable.text = "Некорректный Email"
        lable.isHidden = true
        return lable
    }()
    
    private lazy var emailErrorLableConstraints = [
        self.emailErrorLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        self.emailErrorLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        self.emailErrorLable.topAnchor.constraint(equalTo: self.stackTextViews.bottomAnchor, constant: 2),
        self.emailErrorLable.heightAnchor.constraint(equalToConstant: 10)
    ]
    
    @objc private func didTapButton(sender: UIButton) {
        self.passwordErrorLable.isHidden = true
        self.emailErrorLable.isHidden = true
        
        guard self.emailText != nil,
              self.emailText != "" else {
                  isEmptyTextField(self.emailTextField, 0.35)
                  return
              }
        
        guard self.passwordText != nil,
              self.passwordText != "" else {
                  isEmptyTextField(self.passwordTextField, 0.35)
                  return
              }
        
        guard emailValidate(for: self.emailText!) else {
            self.emailErrorLable.isHidden = false
            return
        }
        
        guard self.isValidated(self.passwordText!) else {
            self.passwordErrorLable.isHidden = false
            return
        }
        
        guard self.emailText == self.standartLogin,
              self.passwordText == self.standertPassword else {
                  self.delegateButtonAlert?.didTapButtonAlert()
                  return
              }
        
        self.delegateButtonEnter?.didTapButtonEnter()
        self.clearTextField()
    }
    
    private func clearTextField() {
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        self.emailText = nil
        self.passwordText = nil
        self.passwordErrorLable.isHidden = true
        self.emailErrorLable.isHidden = true
    }

    @objc private func emailTextChange(_ textField: UITextField) {
        self.emailText = textField.text
    }

    @objc private func passwordTextChange(_ textField: UITextField) {
        self.passwordText = textField.text
    }
    
    private func isValidated(_ password: String) -> Bool {
        if password.count >= 8 {
            return true
        }
        return false
    }
}





