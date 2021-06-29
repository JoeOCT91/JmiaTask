//
//  ItemDetailViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ItemDetailViewModel {
    
    private let itemDetailRepository = ProductRepository()

    public func getProductDetail(sku: String) -> Observable<DataResult<ProductDataResult>>{
        return itemDetailRepository.getProductDetails(sku: sku)
    }
}
