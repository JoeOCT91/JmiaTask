//
//  AppDelegate.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupNavigationController()
        return true
    }
}

extension AppDelegate {
    
    private func setupNavigationController() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let search = SearchViewController()
        let viewController = UINavigationController(rootViewController: search)
        window?.rootViewController = viewController
    }
}
