//
//  TabBarViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    lazy var homeViewController:UINavigationController = {
        let d =  UINavigationController(rootViewController: HomeViewController())
        d.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        return d
    }()
    
    lazy var favoritesViewController:UINavigationController = {
        let d = UINavigationController(rootViewController: FavoritesViewController())
        d.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), tag: 1)
        return d
    }()
    
    lazy var mapViewCotroller:UINavigationController = {
        let c =  UINavigationController(rootViewController: MapViewController())
        c.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag:3)
        return c
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = homeViewController.title
        UITabBar.appearance().tintColor = UIColor.tanHide

        viewControllers = [homeViewController, favoritesViewController, mapViewCotroller]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
