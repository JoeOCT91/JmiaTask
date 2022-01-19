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
}

class ResultVM: ResultVMProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private var anyCancelable = Set<AnyCancellable>()
    @Published private var productsList = [Product]()
    internal var resultListPublisher: Published<[Product]>.Publisher {$productsList}
    internal var currentValueIndex = CurrentValueSubject<Int, Never>(0)
    
    private var currentPage: Int = 1
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
        APIManager.searchFor(product: product, page: currentPage).sink { error in
            switch error {
                
            case .finished:
                break
            case .failure(let fail):
                print(String(describing: fail))
            }
        }
    receiveValue: { result in
        self.productsList.append(contentsOf: result.metadata.results)
        self.currentPage += 1
        
    }
    .store(in: &anyCancelable)
    }
    
    private func paginationControl() {
        currentValueIndex.sink { [weak self] currentIndex in
            guard let self = self else { return }
            if currentIndex + 1 == self.productsList.count {
                self.getSearchResultFor(product: self.searchKeyword)
                print("last item reached")
            }
        }.store(in: &anyCancelable)
    }
}
