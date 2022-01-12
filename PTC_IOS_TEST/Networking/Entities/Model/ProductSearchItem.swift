//
//  ProductSearchItem.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

struct ProductSearchItem : Codable {
    // MARK: - Proprties
    var sku : String = ""
    var name : String = ""
    var brand : String = ""
    var max_saving_percentage : Double = 0
    var price : Double = 0
    var special_price : Double = 0
    var image : String = ""
    var rating_average : Int?
}
