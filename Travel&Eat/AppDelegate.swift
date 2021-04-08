//
//  AppDelegate.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if (DefaultsData().onboardingViewed) {
            window?.rootViewController = TabBarViewController()
        } else {
            window?.rootViewController = OnboardingPageViewController()
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

