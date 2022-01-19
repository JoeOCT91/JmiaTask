//
//  HomeCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class HomeCoordinator: ChildCoordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeVC.createHomeVC(coordinator: self)
        self.navigationController.viewControllers = [homeVC]
    }
    
    func pushResultVC(searchFor: String) {
        let resultVC = ResultVC.createResult(searchFor: searchFor, coordinator: self)
        navigationController.pushViewController(resultVC, animated: true)
    }
    
    func pushProductInformation(productIdentifier: String) {
        let productInformationVC = ProductInformationVC.createProductInformationView(productIdentifier: productIdentifier, coordinator: self)
        self.navigationController.pushViewController(productInformationVC,animated: true)
    }
}
