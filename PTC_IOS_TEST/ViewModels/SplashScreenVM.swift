//
//  SplashScreenVM.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

protocol SplashScreenVMProtocol: AnyObject {
    
}

class SplashScreenVM: SplashScreenVMProtocol{
    
    
    
    init() {
        
    }
    
    func getConfiguration() {
        APIManager.getConfigurations() { response in
            switch response {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
