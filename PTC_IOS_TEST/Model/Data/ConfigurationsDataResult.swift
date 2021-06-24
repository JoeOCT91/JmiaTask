//
//  ConfigrationDataResult.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import ObjectMapper

struct ConfigurationsDataResult : Mappable {
    var currency : Currency?
    var languages : [Languages]?
    var support : Support?
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        currency <- map["currency"]
        languages <- map["languages"]
        support <- map["support"]
    }
    
}

struct Currency : Mappable {
    var iso : String?
    var currency_symbol : String?
    var position : Int?
    var decimals : Int?
    var thousands_sep : String?
    var decimals_sep : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        iso <- map["iso"]
        currency_symbol <- map["currency_symbol"]
        position <- map["position"]
        decimals <- map["decimals"]
        thousands_sep <- map["thousands_sep"]
        decimals_sep <- map["decimals_sep"]
    }
    
}

struct Languages : Mappable {
    var code : String?
    var name : String?
    var isDefault : Bool?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        code <- map["code"]
        name <- map["name"]
        isDefault <- map["default"]
    }
    
}

struct Support : Mappable {
    var phone_number : String?
    var call_to_order_enabled : Bool?
    var cs_email : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        phone_number <- map["phone_number"]
        call_to_order_enabled <- map["call_to_order_enabled"]
        cs_email <- map["cs_email"]
    }
    
}
