//
//  ButtonPushDelegate.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import Foundation

protocol ButtonPushDelegate: AnyObject {
    func didTapButtonEnter()
}

protocol ButtonAlertDelegate: AnyObject {
    func didTapButtonAlert()
}

protocol CellPushDelegate: AnyObject {
    func didTapCell(for id: Int)
}
