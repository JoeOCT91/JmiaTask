//
//  SplashViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 26/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel {
    
    private let splashScreenRepository = SplashRepository()

    public func isLoggedIn() -> Observable<DataResult<ConfigurationsDataResult>>{
        return splashScreenRepository.getConfigurations().delay(.seconds(3), scheduler: MainScheduler.instance)
    }

}
