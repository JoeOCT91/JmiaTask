//
//  ProductDetails.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
struct ProductDetails : Codable {
    // MARK: - Proprties
    var sku : String = ""
    var name : String = ""
    var max_saving_percentage : Double = 0.0
    var price : Double = 0.0
    var special_price : Double = 0.0
    var brand : String = ""
    var rating : Rating?
    var image_list : [String] = []
    var summary : Summary
    var seller_entity : Seller?
    
    
}

struct Rating : Codable {
    // MARK: - Proprties
     var average: Int = 0
     var ratings_total:Int = 0

}

struct Summary : Codable {
    // MARK: - Proprties
     var short_description: String = ""
     var description : String = ""
}

struct Seller : Codable {
    var id: Int = 0
    var name : String = ""
    var delivery_time : String = ""
}
     
