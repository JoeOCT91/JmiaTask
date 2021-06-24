//
//  BaseObjectResponse.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse <T: Mappable> : Mappable{
    var data : T?
    var success : Bool?
    var error : BaseError?
    var session : Session?
    
    init?(code: Int) {
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["metadata"]
        success <- map["success"]
        error <- map["messages"]
        session <- map["session"]
    }
}


struct BaseError : Mappable {
    private var error : Error?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
    }
    
    func errorMessage() -> String? {
        return error?.message
    }
    
    func errorReaseon() -> String? {
        return error?.reason
    }
}

struct Error : Mappable {
    var reason : String?
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        reason <- map["reason"]
        message <- map["message"]
    }

}

struct Session : Mappable {
    var id : String?
    var expire : String?
    var token : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        expire <- map["expire"]
        token <- map["YII_CSRF_TOKEN"]
    }

}
