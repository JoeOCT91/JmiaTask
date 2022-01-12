//
//  ProductDetailsViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import RxSwift

class ProductDetailsViewModel: ProductDetailsViewModelProtocol , ProductDetailsViewModelEvents  {
    var productDetails: PublishSubject<ProductDetailsViewData>
    var productImages : BehaviorSubject<[String]>
    var isLoading: BehaviorSubject<Bool>
    var onError: PublishSubject<String>
    var selectedImage: PublishSubject<String>
    var outputs: ProductDetailsViewModelOutput {return self}
    var inputs: ProductDetailsViewModelInput {return self}
    let disposeBag = DisposeBag()
    var sku : Int = -1
    var apiService : ProductDetailsServiceProtocol
    
    init() {
        productDetails = PublishSubject<ProductDetailsViewData>()
        productImages = BehaviorSubject<[String]>(value: [])
        isLoading = BehaviorSubject<Bool>(value: false)
        onError = PublishSubject<String>()
        selectedImage = PublishSubject<String>()
        apiService = ProductDetailsService()
    }
    
    func getProductDetails(){
     //   let sku = (sku != 1 || sku != 2) ? Int.random(in: 1...2) : sku
        let result = apiService.fetchProductDetails(with: sku)
            .map{ meta in ProductDetailsViewData(with: meta)}
        
        result.subscribe { [weak self] event in
            guard let self = self else { return }
            if let info = event.element {
                self.productDetails.onNext(info)
                self.productImages.onNext(info.images)
            }
            else if let ex = event.error {
                self.onError.onNext(ex.localizedDescription)
            }
        }.disposed(by: disposeBag)

    }
}
