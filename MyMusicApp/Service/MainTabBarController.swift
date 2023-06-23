//
//  MainTabBarController.swift
//  MyMusicApp
//
//  Created by Владислав on 12.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .brandBlack
            tabBar.standardAppearance = appearance
        } else {
            tabBar.backgroundColor = .brandBlack
        }
        
        tabBar.tintColor = .brandGreen
        tabBar.unselectedItemTintColor = .neutralGray
    }
    
    private func setupItems() {
        
        let homepage = HomepageViewController()
        let explore = ExploreViewController()
        let favorites = FavoritesViewController()
        let profile = ProfileViewController()
        
        homepage.bindFavoriteViewController(controller: favorites)
        
        
        setViewControllers([homepage, explore, favorites, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "home")
        items[0].title = "Home"
        items[1].image = UIImage(named: "explore")
        items[1].title = "Explore"
        items[2].image = UIImage(named: "like")
        items[2].title = "Favorites"
        items[3].image = UIImage(named: "profile")
        items[3].title = " Account"
    }
}
