//
//  ProductDetailsViewData.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import Foundation
struct ProductDetailsViewData {
    // MARK: - Proprties
    var sku : String
    var name : String
    var savingPercentage : String
    var price : String
    var specialPrice : String
    var brand : String
    var rating : Double
    var totalRating : String
    var images : [String]
    var summary : String
    var sellerName : String
    
    init(with item : ProductDetails) {
        self.sku = item.sku
        self.name = item.name
        self.savingPercentage = "-\( String(format: "%.1f", item.max_saving_percentage))"
        self.price = item.price.toStringCurrency
        self.specialPrice =  item.special_price.toStringCurrency
        self.brand = item.brand
        self.rating = Double(item.rating?.average ?? 0)
        self.totalRating = " \(Int(exactly: item.rating?.ratings_total ?? 0)!) ratings"
        self.images = item.image_list
        self.summary = item.summary.short_description
        self.sellerName = item.seller_entity?.name ?? "anonymous"
    }
}
