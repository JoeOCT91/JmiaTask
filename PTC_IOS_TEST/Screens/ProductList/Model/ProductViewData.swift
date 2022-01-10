//
//  ProductViewData.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

struct ProductViewData {
    // MARK: - Proprties
    var sku : Int
    var name : String
    var brand : String
    var savingPercentage : String
    var price : String
    var specialPrice : String
    var image : String
    var ratingAverage : Int
    
    //MARK - Init
    init(with item : ProductSearchItem) {
        self.sku = Int(item.sku)! // It's essential so it wont be nil
        self.name = item.name
        self.brand = item.brand
        self.price =  item.price.toStringCurrency
        self.specialPrice =   item.special_price.toStringCurrency
        self.savingPercentage =  " -\(String(format: "%.1f", item.max_saving_percentage)) % "
        self.image = item.image
        self.ratingAverage = item.rating_average ?? 0
    }
}
