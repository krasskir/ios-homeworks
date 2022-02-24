//
//  ViewModelProtocol.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
