//
//  SearchViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 28/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    private let searchRepository = SearchRepository()

    public func search(query: String, pageNumber: Int) -> Observable<DataResult<SearchDataResult>>{
        return searchRepository.search(query: query, pageNumber: pageNumber)
    }

}
