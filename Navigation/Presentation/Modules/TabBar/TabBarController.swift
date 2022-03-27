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
        case gestures
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            case .gestures:
                return "Жесты"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
            case .profile:
                return UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
            case .gestures:
                return UIImage(systemName: "eyes", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }

    func setUpTabBar() {
        let items: [TabBarItem] = [.feed, .profile, .gestures]
        
        self.viewControllers = items.map( { TabBarItem in
            switch TabBarItem {
            case .feed:
                return UINavigationController(rootViewController: ProfileViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
            case .gestures:
                return UINavigationController(rootViewController: GestureViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach( { (index, viewController) in
            viewController.tabBarItem.title = items[index].title
            viewController.tabBarItem.image = items[index].image
        })
    }
}
