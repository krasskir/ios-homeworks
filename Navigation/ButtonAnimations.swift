//
//  ButtonAnimations.swift
//  Navigation
//
//  Created by Kirill Krasavin on 19.02.2022.
//

import UIKit

func animateTap(_ viewToAnimate: UIView, _ duration: TimeInterval) {
    UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
        viewToAnimate.transform =  CGAffineTransform(scaleX: 0.95, y: 0.95)
    }) { (_) in
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            viewToAnimate.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
}

func animateHoldRelease(_ viewToAnimate: UIView, _ scale: CGFloat, _ duration: TimeInterval) {
    UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
        viewToAnimate.transform =  CGAffineTransform(scaleX: scale, y: scale)
    })
}
