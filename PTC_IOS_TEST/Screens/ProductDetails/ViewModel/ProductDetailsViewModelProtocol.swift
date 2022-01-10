//
//  ProductDetailsViewModelProtocol.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import RxSwift

protocol  ProductDetailsViewModelOutput {
    var productDetails : PublishSubject<ProductDetailsViewData> {get}
    var productImages : BehaviorSubject<[String]> {get}
    var isLoading : BehaviorSubject<Bool> {get}
    var onError : BehaviorSubject<String> {get}
}

protocol ProductDetailsViewModelInput {
    var selectedImage : PublishSubject<String> {get}
}

protocol ProductDetailsViewModelProtocol {
    var outputs : ProductDetailsViewModelOutput {get}
    var inputs : ProductDetailsViewModelInput {get}
    func getProductDetails()
}

typealias ProductDetailsViewModelEvents = ProductDetailsViewModelOutput & ProductDetailsViewModelInput
