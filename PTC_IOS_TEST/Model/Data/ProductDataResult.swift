//
//  ProductDataResult.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductDataResult : Mappable {
    var sku : String?
    var name : String?
    var maxSavingPercentage : Int?
    var price : Int?
    var specialPrice : Int?
    var brand : String?
    var rating : Rating?
    var images : [String]?
    var summary : Summary?
    var sellerEntity : SellerEntity?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        sku <- map["sku"]
        name <- map["name"]
        maxSavingPercentage <- map["max_saving_percentage"]
        price <- map["price"]
        specialPrice <- map["special_price"]
        brand <- map["brand"]
        rating <- map["rating"]
        images <- map["image_list"]
        summary <- map["summary"]
        sellerEntity <- map["seller_entity"]
    }
    
}

struct Rating : Mappable {
    var average : Int?
    var ratingsTotal : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        average <- map["average"]
        ratingsTotal <- map["ratings_total"]
    }
    
}

struct SellerEntity : Mappable {
    var id : Int?
    var name : String?
    var deliveryTime : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        deliveryTime <- map["delivery_time"]
    }
    
}

struct Summary : Mappable {
    var shortDescription : String?
    var description : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        shortDescription <- map["short_description"]
        description <- map["description"]
    }
    
}
