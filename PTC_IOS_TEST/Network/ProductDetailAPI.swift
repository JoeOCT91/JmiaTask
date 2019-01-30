//
//  ProductDetailAPI.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

class ProductDetailAPI: ProductDetailStoreProtocol, APIClient {
    func fetchProductDetail(with endpoint: MockLabsEndpoints, completionHandler: @escaping productDetailDataCompletionHandler) {
        let request = endpoint.request
        fetch(with: request, completion: completionHandler)
    }
}
