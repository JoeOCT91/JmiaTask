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

class BaseViewController: UIViewController {
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
    
}
