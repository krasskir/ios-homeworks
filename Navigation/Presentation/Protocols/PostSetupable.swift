//
//  ViewModelProtocol.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import Foundation

protocol PostViewCellProtocol {}

protocol PhotoViewCellPorotocol {}

protocol PostSetupable {
    func setup(with viewModel: PostViewCellProtocol)
}

protocol PhotoSetupable {
    func setup(with viewModel: PhotoViewCellPorotocol)
}
