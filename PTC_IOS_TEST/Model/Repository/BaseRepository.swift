//
//  BaseRepository.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift


class BaseRepository {
    
    func onSuccess<T>(baseDataResultObservable: BehaviorSubject<DataResult<T>>,data : T){
        baseDataResultObservable.onNext(DataResult.Success(data: data))
        baseDataResultObservable.dispose()
    }
    func onError<T>(baseDataResultObservable: BehaviorSubject<DataResult<T>>, errorDataResult: DataResult<T>){
        baseDataResultObservable.onNext(errorDataResult)
        baseDataResultObservable.dispose()
    }
    
    func createObservable<T>() -> BehaviorSubject<DataResult<T>>{
        return BehaviorSubject<DataResult<T>>(value: DataResult.Loading())
    }
    
    func isSuccess<T>(baseDataResultObservable: BehaviorSubject<DataResult<T>>, dataResult: DataResult<T>) -> Bool{
        return dataResult.status == DataResult.Status.success && dataResult.data != nil
    }
    
}
