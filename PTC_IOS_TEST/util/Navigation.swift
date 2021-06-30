//
//  navigation.swift
//  ESS IOS
//
//  Created by Mahmoud El-Melligy on 9/15/20.
//  Copyright © 2020 com.ElArabyGroup. All rights reserved.
//

import Foundation
import UIKit


public  func getNextViewContoller(navigateKey : NavigationKeys)-> UIViewController{
    var nextViewController : UIViewController!
    switch navigateKey {
    case .SEARCH_SCREEN:
        nextViewController = UIStoryboard(name: "SearchScreen", bundle: nil).instantiateViewController(identifier: "SearchScreen") as! UINavigationController
    default:
        break
    }
    nextViewController.modalPresentationStyle = .fullScreen
    nextViewController.modalTransitionStyle = .crossDissolve
    return nextViewController
    
}


public enum NavigationKeys {
    case SEARCH_SCREEN
}

extension UINavigationController{
    var previousViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
