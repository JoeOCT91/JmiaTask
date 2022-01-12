//
//  AppDelegate.swift
//  PTC_IOS_TEST
//
//  Created by Tiago Valente on 27/06/2019.
//  Copyright © 2019 Jumia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController()
        coordinator  = MainCoordinator(navigation: navigation)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        coordinator?.start()
        return true
    }


}

