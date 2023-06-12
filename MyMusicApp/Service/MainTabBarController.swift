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
        tabBar.backgroundColor = .brandBlack
        tabBar.tintColor = .brandGreen
        tabBar.unselectedItemTintColor = .neutralGray
    }
    
    private func setupItems() {
        
        let homepage = HomepageViewController()
        let favorites = FavoritesViewController()
        let profile = ProfileViewController()
        

        setViewControllers([homepage, favorites, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "home")
        items[0].title = "Home"
        items[1].image = UIImage(named: "like")
        items[1].title = "Favorites"
        items[2].image = UIImage(named: "profile")
        items[2].title = " Account"
    }
}
