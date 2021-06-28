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
    var currencySymbol : String?
    var position : Int?
    var decimals : Int?
    var thousandsSep : String?
    var decimalsSep : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        iso <- map["iso"]
        currencySymbol <- map["currency_symbol"]
        position <- map["position"]
        decimals <- map["decimals"]
        thousandsSep <- map["thousands_sep"]
        decimalsSep <- map["decimals_sep"]
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
    var phoneNumber : String?
    var callToOrderEnabled : Bool?
    var csEmail : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        phoneNumber <- map["phone_number"]
        callToOrderEnabled <- map["call_to_order_enabled"]
        csEmail <- map["cs_email"]
    }
    
}
