//
//  SplashRepository.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper


class SplashRepository: BaseRepository{
    
    func getConfigurations() -> BehaviorSubject<DataResult<ConfigurationsDataResult>> {
        let observable: BehaviorSubject<DataResult<ConfigurationsDataResult>> = createObservable()
        NetworkManger.configurationsRequest() { (dataResult: DataResult<ConfigurationsDataResult>) in
            if self.isSuccess(baseDataResultObservable: observable, dataResult: dataResult){
                LocalStorage.saveCurrencySymbol(currency: dataResult.data?.currency)
                self.onSuccess(baseDataResultObservable: observable, data: dataResult.data!)
            }else{
                self.onError(baseDataResultObservable: observable, errorDataResult: dataResult)
            }
        }
        return observable
    }
}
