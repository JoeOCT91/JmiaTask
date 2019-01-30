//
//  SearchProducWorker.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//


import Foundation

typealias productListDataCompletionHandler = (Either<ProductListModel>) -> Void

protocol ProductListStoreProtocol {
    func fetchProductList(with endpoint: MockLabsEndpoints, completionHandler: @escaping productListDataCompletionHandler)
}

class ProductListWorker {
    
    var productListStore: ProductListStoreProtocol
    
    init(productListStoreProtocol: ProductListStoreProtocol) {
        productListStore = productListStoreProtocol
    }
    
    func fetchProductList(with endpoint: MockLabsEndpoints,
                      completionHandler: @escaping productListDataCompletionHandler) {
        productListStore.fetchProductList(with: endpoint) { either in
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

