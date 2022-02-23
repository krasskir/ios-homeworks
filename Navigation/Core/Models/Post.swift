//
//  Post.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

struct Post {
    private let randomInt = Int.random(in: 10...10000)
    
    let title: String
    let author: String
    let image: String
    
    lazy var views: Int = randomInt
    lazy var likes: Int = Int.random(in: 10...randomInt)
}
