//
//  ProductSearchService.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import RxSwift

protocol ProductSearchServiceProtocol {
    func searchProducts(query: String, page: Int ) -> Observable<SearchMetaData>
}

class ProductSearchService  : ProductSearchServiceProtocol {

    var api : APIManagerProtocol!
    
    init(api : APIManagerProtocol = APIManager()) {
        self.api = api
    }
    
    func searchProducts(query: String, page: Int) -> Observable<SearchMetaData>{

        return Observable.create { observable in
            
            self.api.request(endpoint: .searchProducts(query, page), method: .GET, params: nil) { (response : Result<ProductsListSearchResponse, ApiError>)  in
                
                if case .success(let data) = response  , data.success , let info = data.metadata {
                    observable.onNext(info)
                }
                else if case .failure(let ex) = response {
                    observable.onError(ex)
                }
                /* observable.onError(ApiError.internalError) */
            }
            return Disposables.create()
        }
    }
}
