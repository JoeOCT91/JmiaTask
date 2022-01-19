//
//  ResultVM.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import Combine

protocol ResultVMProtocol: AnyObject {
    var resultListPublisher: Published<[Product]>.Publisher {get}
    var currentValueIndex: CurrentValueSubject<Int ,Never> { get set }
    var errorOccurredWhileGettingDataPublisher : Published<Bool>.Publisher { get }
    var isLoadingDataPublisher : Published<Bool>.Publisher { get }

    
}

class ResultVM: ResultVMProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    private var anyCancelable = Set<AnyCancellable>()
    @Published private var productsList = [Product]()
    @Published private var isLoadingData = false
    @Published private var isError = false
    internal var resultListPublisher: Published<[Product]>.Publisher {$productsList}
    internal var errorOccurredWhileGettingDataPublisher : Published<Bool>.Publisher {$isError}
    internal var isLoadingDataPublisher: Published<Bool>.Publisher {$isError}
    internal var currentValueIndex = CurrentValueSubject<Int, Never>(0)
    
    
    private var currentPage: Int = 1
    private var availableItems: Int = 0
    private var searchKeyword: String
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle
    //----------------------------------------------------------------------------------------------------------------
    init(searchFor: String) {
        self.searchKeyword = searchFor
        getSearchResultFor(product: searchFor)
        paginationControl()
    }
    
    deinit {
        print("\(String(describing: self)) has been deisnalized...")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private Methods
    //----------------------------------------------------------------------------------------------------------------
    private func getSearchResultFor(product: String) {
        isLoadingData = true
        APIManager.searchFor(product: product, page: currentPage)
            .sink { response in
                self.isLoadingData = false
                if response.error == nil {
                    guard let response = response.value else { return }
                    if response.success {
                        self.productsList.append(contentsOf: response.metadata.results)
                        self.availableItems = response.metadata.totalProducts
                        self.currentPage += 1
                    } else {
                        self.isError = true
                    }
                } else {
                    switch response.error {
                    case.InternalError404:
                        self.isError = true
                    default:
                        self.isError = true
                    }
                }
            }
            .store(in: &anyCancelable)
    }
    
    private func paginationControl() {
        currentValueIndex.sink { [weak self] currentIndex in
            guard let self = self else { return }
            if currentIndex + 1 == self.productsList.count && self.productsList.count < self.availableItems {
                self.getSearchResultFor(product: self.searchKeyword)
            }
        }.store(in: &anyCancelable)
    }
}
