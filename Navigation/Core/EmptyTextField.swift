//
//  isEmptyTextField.swift
//  Navigation
//
//  Created by Kirill Krasavin on 27.03.2022.
//

import UIKit

func isEmptyTextField(_ viewToAnimate: UIView, _ duration: TimeInterval) {
    UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
        viewToAnimate.transform =  CGAffineTransform(scaleX: 0.985, y: 0.985)
        viewToAnimate.layer.borderColor = UIColor.systemRed.cgColor
        viewToAnimate.layer.borderWidth = 1.5
    }) { (_) in
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            viewToAnimate.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
            viewToAnimate.layer.borderColor = UIColor.lightGray.cgColor
            viewToAnimate.layer.borderWidth = 0.5
        }, completion: nil)
    }
}

func spaceValidate(string: String) -> Bool {
    return (string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil) || (string.rangeOfCharacter(from: CharacterSet.alphanumerics) != nil)
}
