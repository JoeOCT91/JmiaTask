//
//  SplashScreen.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {
    
    private weak var coordinator: Coordinator?
    private var viewModel: SplashScreenVMProtocol!
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    
    class func createSplashScreen(coordinator: Coordinator) -> SplashScreenVC {
        let splashScreen = SplashScreenVC()
        let viewModel = SplashScreenVM()
        splashScreen.coordinator = coordinator
        splashScreen.viewModel = viewModel
        return splashScreen
    }
    
}
