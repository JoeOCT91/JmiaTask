//
//  SearchDataResult.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchDataResult : Mappable {
    var sort : String?
    var total_products : Int?
    var title : String?
    var results : [Results]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        sort <- map["sort"]
        total_products <- map["total_products"]
        title <- map["title"]
        results <- map["results"]
    }
    
}

struct Results : Mappable {
    var sku : String?
    var name : String?
    var brand : String?
    var max_saving_percentage : Int?
    var price : Int?
    var special_price : Int?
    var image : String?
    var rating_average : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        sku <- map["sku"]
        name <- map["name"]
        brand <- map["brand"]
        max_saving_percentage <- map["max_saving_percentage"]
        price <- map["price"]
        special_price <- map["special_price"]
        image <- map["image"]
        rating_average <- map["rating_average"]
    }
    
}
