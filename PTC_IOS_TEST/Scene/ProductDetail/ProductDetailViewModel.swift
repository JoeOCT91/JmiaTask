//
//  ProductDetailViewModel.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

public protocol ProductDetailViewModelDelegate: class {
    func showDetail()
    func showEmptyState()
}

public class ProductDetailViewModel {
    
    private var worker: ProductDetailWorker
    
    public weak var delegate: ProductDetailViewModelDelegate?
    public var detail: ProductResultModel?
    public var productId = 1
    
    init(productDetailStoreProtocol: ProductDetailStoreProtocol = ProductDetailAPI()) {
        worker = ProductDetailWorker(productDetailStoreProtocol: productDetailStoreProtocol)
    }
    
    public func fetchProductDetail() {

        let endPoint = MockLabsEndpoints.produtDetail(id: productId)
        worker.fetchProductDetail(with: endPoint) { [weak self] either in
            if let safeSelf = self {
                switch either {
                case .success(let productDetail):
                    safeSelf.detail = productDetail.metadata
                    safeSelf.delegate?.showDetail()
                case .error:
                    safeSelf.delegate?.showEmptyState()
                }
            }
        }
    }
}
