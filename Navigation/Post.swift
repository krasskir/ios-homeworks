//
//  Post.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import Foundation

protocol Posts {
    var title: String { get }
}

struct Post: Posts {
    let title: String
}
