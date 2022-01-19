//
//  AppCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SwifterSwift

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController  { get set }
    var childCoordinators: [ChildCoordinator] { get set }
    func start()
}
// Note : There is no use of this protocol in this Demo ...
protocol ChildCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: AppCoordinator? { get }
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
        let splashViewController = SplashScreenViewController.createSplashScreen(coordinator: self)
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
    
    func presentHomeScreenAsWidowMainView() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        self.childCoordinators.append(homeCoordinator)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
        self.window.switchRootViewController(to: navigationController, animated: true, options: .curveEaseIn)
    }

}
