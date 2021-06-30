//
//  DataResult.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//


import Foundation

struct DataResult <T> {
    var data : T?
    var errorMessage : String?
    var errorReason: String?
    var status : Status
    var errorType: ErrorType?
    
    
    init(status: Status) {
        self.status = status
    }
    
    init(status: Status, data: T?) {
        self.status = status
        self.data = data
    }
    
    init(status: Status, errorMessage : String?, errorReason : String?, errorType : ErrorType) {
        self.status = status
        self.errorMessage = errorMessage
        self.errorReason = errorReason
        self.errorType = errorType
    }
    
    
    public enum ErrorType{
        case SERVER_ERROR
        case CONNECTION_ERROR
    }
    
    public enum Status{
        case success
        case error
        case loading
    }
        
    static func Success(data : T?)-> DataResult<T>{
        return DataResult(status: Status.success,data: data)
    }
    
    static func Error(errorMessage : String?, errorReason : String?, errorType : ErrorType)-> DataResult<T>{
        return DataResult(status: Status.error, errorMessage: errorMessage, errorReason: errorReason, errorType : errorType )
    }
    
    static func Loading()-> DataResult<T>{
        return DataResult(status: Status.loading)
    }
        
}
