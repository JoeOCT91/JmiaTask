//
//  ProductListViewModel.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

protocol ProductListViewModelDelegate: class {
    func updateList(with animation: Bool)
    func preventScrolling()
    func showTitle()
    func showEmptyState()
}

class ProductListViewModel {
    
    private var page = 1
    private var worker: ProductListWorker
    
    public weak var delegate: ProductListViewModelDelegate?
    public var results = [ProductResultModel]()
    public var query = ""
    public var title = ""
    
    init(productListStoreProtocol: ProductListStoreProtocol = ProductListAPI()) {
        worker = ProductListWorker(productListStoreProtocol: productListStoreProtocol)
    }
    
    public func fetchProductList(nextPage: Bool) {
        if nextPage {
            page += 1
        }
        let endPoint = MockLabsEndpoints.productList(query: query, page: page)
        worker.fetchProductList(with: endPoint) { [weak self] either in
            if let safeSelf = self {
                switch either {
                case .success(let productList):
                    safeSelf.results.append(contentsOf: productList.metadata.results)
                    safeSelf.title = productList.metadata.title
                    safeSelf.delegate?.showTitle()
                    safeSelf.delegate?.updateList(with: true)
                case .error:
                    safeSelf.results.isEmpty ? safeSelf.delegate?.showEmptyState() : safeSelf.delegate?.preventScrolling()
                    }
            }
        }
    }
    
}
