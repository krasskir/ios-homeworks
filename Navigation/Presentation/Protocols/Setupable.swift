//
//  ViewModelProtocol.swift
//  Navigation
//
//  Created by Kirill Krasavin on 23.02.2022.
//

import Foundation

protocol PostViewCellProtocol {}

protocol PhotoTableViewCellPorotocol {}

protocol PhotoCollectionViewCellPorotocol {}

protocol PostSetupable {
    func setup(with viewModel: PostViewCellProtocol)
}

protocol PhotoTableSetupable {
    func setup(with viewModel: PhotoTableViewCellPorotocol)
}

protocol PhotoCollectionSetupable {
    func setup(with viewModel: PhotoCollectionViewCellPorotocol)
}
