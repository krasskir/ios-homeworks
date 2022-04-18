//
//  loginAlertController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.03.2022.
//

import UIKit

class LoginAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Данные введены некорректно"
        self.message = "Неправильно введен логин или пароль \n Попробуйте снова или восстановите пароль, правда эту фичу мы пока не добавили, так что напрягайте память и пейте витамины ;)"
        
        self.addAction(UIAlertAction(title: "Попробовать снова", style: .cancel, handler: nil))
    }

}
