//
//  ProductDetailsService.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import RxSwift
protocol ProductDetailsServiceProtocol {
    func fetchProductDetails(with sku : Int) -> Observable<ProductDetails>
}

class ProductDetailsService : ProductDetailsServiceProtocol {
    
    var api : APIManagerProtocol!
    
    init(api : APIManagerProtocol = APIManager()) {
        self.api = api
    }
    
    func fetchProductDetails(with sku : Int) -> Observable<ProductDetails>{
        return Observable.create { [weak self] observable in
            
            self?.api.request(endpoint: .productDetails(sku), method: .GET , params : nil) {
                (response : Result<ProductDetailsResponse , ApiError>) in
                
                if case .success(let info) = response , let meta = info.metadata {
                    
                    observable.onNext(meta)
                }
                else if case .failure(let ex) = response {
                    observable.onError(ex)
                }
             }
            
            return Disposables.create()
        }
    }
    
    
}
