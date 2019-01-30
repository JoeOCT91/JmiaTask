//
//  ProductDetailWorker.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

typealias productDetailDataCompletionHandler = (Either<ProductDetailModel>) -> Void

protocol ProductDetailStoreProtocol {
    func fetchProductDetail(with endpoint: MockLabsEndpoints, completionHandler: @escaping productDetailDataCompletionHandler)
}

class ProductDetailWorker {
    
    var productDetailStore: ProductDetailStoreProtocol
    
    init(productDetailStoreProtocol: ProductDetailStoreProtocol) {
        productDetailStore = productDetailStoreProtocol
    }
    
    func fetchProductDetail(with endpoint: MockLabsEndpoints,
                      completionHandler: @escaping productDetailDataCompletionHandler) {
        productDetailStore.fetchProductDetail(with: endpoint) { either in
            switch either {
            case .success(let productList):
                DispatchQueue.main.async {
                    completionHandler(.success(productList))
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completionHandler(.error(error))
                }
            }
        }
    }
}


