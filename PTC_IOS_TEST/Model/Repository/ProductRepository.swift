//
//  ProductRepository.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper


class ProductRepository: BaseRepository{
    
    func getProductDetails(sku: String) -> BehaviorSubject<DataResult<ProductDataResult>> {
        let observable: BehaviorSubject<DataResult<ProductDataResult>> = createObservable()
        NetworkManger.productRequest(sku: sku) { (dataResult: DataResult<ProductDataResult>) in
            if self.isSuccess(baseDataResultObservable: observable, dataResult: dataResult){
                self.onSuccess(baseDataResultObservable: observable, data: dataResult.data!)
            }else{
                self.onError(baseDataResultObservable: observable, errorDataResult: dataResult)
            }
        }
        return observable
    }
}
