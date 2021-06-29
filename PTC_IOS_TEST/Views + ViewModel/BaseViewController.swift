//
//  BaseViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 26/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import DropDown


class BaseViewController: UIViewController {
    var dropButton = DropDown()
    let baseDisposeBag = DisposeBag()
    var loadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var badgeBarButton = BadgeBarButtonItem()
        
    public func showLoadingIndicator(){
        loadingIndicator.center = self.view.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    public func stopLoadingIndicator(){
        loadingIndicator.stopAnimating()
    }
    
    public func navigateController(navigateKey : NavigationKeys){
        self.present(getNextViewContoller(navigateKey: navigateKey), animated: true, completion: nil)
    }
    
    func setupDropDownList(searchBarTextField : UITextField){
        dropButton.anchorView = searchBarTextField
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.textColor = AppColors.blackColor
        dropButton.backgroundColor = AppColors.jumiaOrangeColor
        dropButton.direction = .bottom
        DropDown.startListeningToKeyboard()
    }
}
