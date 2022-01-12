//
//  ProductListViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import RxSwift

class ProductListViewModel : ProductListViewModelProtocol , ProductListViewModeEvents {
    
    var products : BehaviorSubject<[ProductViewData]>
    var isLoading : BehaviorSubject<Bool>
    var isLoadingMore : BehaviorSubject<Bool>
    var onError : PublishSubject<String>
    var reachedBottomTrigger: PublishSubject<Void>
    var outputs : ProductListViewModelOutput {return self}
    var inputs : ProductListViewModelInput {return self}
    let disposeBag = DisposeBag()
    var apiService : ProductSearchService
    var currentPage = 1
    var pageCount = 2
    var query : String

    init() {
        products = BehaviorSubject(value: [])
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        reachedBottomTrigger = PublishSubject<Void>()
        onError = PublishSubject<String>()
        apiService = ProductSearchService()
        query = "phone"
        configureReachedBottomTrigger()
      
    }
    
    func loadProducts(){
        
        isLoading.onNext(currentPage == 1)
       
        let results =  apiService.searchProducts(query: query, page: currentPage)
           .map { meta in
            meta.results.map{ProductViewData(with: $0)}
        }
        
        results.subscribe {[weak self] event in
            guard let self = self else { return }
            if var items = event.element  {
                if self.currentPage > 1 , let oldItems = try? self.products.value() {
                    items.append(contentsOf: oldItems)
                    items.sort(by: {$0.sku < $1.sku}) //   items.reverse()
                  
                }
                self.products.onNext(items)
                self.isLoadingMore.onNext(false)
            }
            else if let error = event.error {
                print("\(error.localizedDescription)")
                self.onError.onNext(error.localizedDescription)
            }
            self.isLoading.onNext(false)
            // error
        }.disposed(by: disposeBag)
    }
    
    func configureReachedBottomTrigger(){
         reachedBottomTrigger.filter{ self.currentPage < self.pageCount}
        .withLatestFrom(isLoadingMore)
        .filter{$0 == false}
        .subscribe{[weak self] event in
            guard let self = self else { return }
            self.isLoadingMore.onNext(true)
            self.currentPage += 1
            self.loadProducts()
        }.disposed(by: disposeBag)
    }
}
