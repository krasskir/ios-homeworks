//
//  AlertController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

class AlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Какое-то предупреждение"
        self.message = "Да все ок, не волнуйся ты так, нажми на любую кнопку и все станет хорошо"
        
        self.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("Все хорошо!")
            }))
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("Отмена!")
            }))
        self.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { action in
                print("Ой-е-е-ей!")
            }))
    }

}
