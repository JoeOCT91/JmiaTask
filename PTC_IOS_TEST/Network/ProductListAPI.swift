//
//  ProductListAPI.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

class ProductListAPI: ProductListStoreProtocol, APIClient {
    func fetchProductList(with endpoint: MockLabsEndpoints, completionHandler: @escaping productListDataCompletionHandler) {
        let request = endpoint.request
        fetch(with: request, completion: completionHandler)
    }
}
