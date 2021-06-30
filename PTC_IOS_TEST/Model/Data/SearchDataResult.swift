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
    var totalProducts : Int?
    var title : String?
    var results : [Results]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        sort <- map["sort"]
        totalProducts <- map["total_products"]
        title <- map["title"]
        results <- map["results"]
    }
    
}

struct Results : Mappable {
    var sku : String?
    var name : String?
    var brand : String?
    var maxSavingPercentage : Int?
    var price : Int?
    var specialPrice : Int?
    var image : String?
    var ratingAverage : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        sku <- map["sku"]
        name <- map["name"]
        brand <- map["brand"]
        maxSavingPercentage <- map["max_saving_percentage"]
        price <- map["price"]
        specialPrice <- map["special_price"]
        image <- map["image"]
        ratingAverage <- map["rating_average"]
    }
    
}
