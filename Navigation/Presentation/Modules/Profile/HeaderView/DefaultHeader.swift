//
//  ProfileHeader.swift
//  Navigation
//
//  Created by Kirill Krasavin on 25.02.2022.
//

import UIKit

class DefaultHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemGroupedBackground
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


