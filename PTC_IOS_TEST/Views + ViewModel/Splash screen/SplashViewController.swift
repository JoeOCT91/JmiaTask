//
//  ViewController.swift
//  PTC_IOS_TEST
//
//  Created by Tiago Valente on 27/06/2019.
//  Copyright © 2019 Jumia. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    let viewModel = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.isLoggedIn().subscribe (onNext: { (configurationsDataResult) in
            if configurationsDataResult.status == .success{
                self.navigateController(navigateKey: NavigationKeys.SEARCH_SCREEN)
            }else{
                //show internet connection error
            }
        }).disposed(by: baseDisposeBag)
    }
}


