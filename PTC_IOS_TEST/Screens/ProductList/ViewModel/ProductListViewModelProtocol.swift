//
//  ProductListViewModelProtocol.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import RxSwift

protocol ProductListViewModelOutput {
    var products : BehaviorSubject<[ProductViewData]> { get}
    var isLoading : BehaviorSubject<Bool> {get}
    var isLoadingMore : BehaviorSubject<Bool> {get}
    var onError : PublishSubject<String> {get}
}

protocol ProductListViewModelInput {
    var reachedBottomTrigger : PublishSubject<Void> {get}
}

protocol ProductListViewModelProtocol {
 
    var outputs : ProductListViewModelOutput {get}
    var inputs : ProductListViewModelInput {get}
    func loadProducts()
    func configureReachedBottomTrigger()
}

typealias ProductListViewModeEvents =    ProductListViewModelOutput & ProductListViewModelInput
