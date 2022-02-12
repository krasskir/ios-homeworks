//
//  ViewController.swift
//  Navigation
//
//  Created by Kirill Krasavin on 12.02.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
            case .profile:
                return UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }

    func setUpTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        
        self.viewControllers = items.map( { TabBarItem in
            switch TabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: ProfileViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach( { (index, viewController) in
            viewController.tabBarItem.title = items[index].title
            viewController.tabBarItem.image = items[index].image
        })
    }
}
