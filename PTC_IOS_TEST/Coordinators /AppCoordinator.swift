//
//  AppCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController  { get set }
    var childCoordinators: [ChildCoordinator] { get set }
    func start()
}
// Note : There is no use of this protocol in this Demo ...
protocol ChildCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: AppCoordinator? { get }
    var tag: Int { get }
    func start()
}


class AppCoordinator: Coordinator {
    
    
    internal var childCoordinators = [ChildCoordinator]()
    internal var navigationController: UINavigationController
    private var window: UIWindow!
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        let vc = SplashScreenVC.createSplashScreen(coordinator: self)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
