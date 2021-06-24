//
//  SearchRepository.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper


class SearchRepository: BaseRepository{
    
    func search(query: String , pageNumber : Int) -> BehaviorSubject<DataResult<SearchDataResult>> {
        let observable: BehaviorSubject<DataResult<SearchDataResult>> = createObservable()
        NetworkManger.searchRequest(query: query,pageNumber: pageNumber) { (dataResult: DataResult<SearchDataResult>) in
            if self.isSuccess(baseDataResultObservable: observable, dataResult: dataResult){
                self.onSuccess(baseDataResultObservable: observable, data: dataResult.data!)
            }else{
                self.onError(baseDataResultObservable: observable, errorDataResult: dataResult)
            }
        }
        return observable
    }
}
