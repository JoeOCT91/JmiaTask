//
//  MainCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/5/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let main = SplashViewController()
        main.coordinator = self
        pushViewControllerToStack(with: main)
   
    }
    
    func showSearch(){
        let search = SearchViewController()
        search.coordinator = self
        pushViewControllerToStack(with: search , isRoot: true)
    }
    
    func showProducts(){
        let main = ProductListViewController()
        main.coordinator = self
        pushViewControllerToStack(with: main)
    }
    
    func showProductDetails(with sku : Int){
        let details = ProductDetailsViewController.instantiateFromStoryboard("ProductDetails")
        details.coordinator = self
        let model = ProductDetailsViewModel()
        model.sku = sku
        details.viewModel = model
        pushViewControllerToStack(with: details)
    }
    
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true , isRoot : Bool = false){
        
        if  isRoot {
            navigationController.viewControllers = []
        }
        navigationController.pushViewController(value, animated: animated)
       
    }
    
}
