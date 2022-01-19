//
//  Product.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable {
    
    let uuid = UUID()
    let productIdentifier: String
    let name: String
    let maxSavingPercentage, price, specialPrice: Int
    let brand: String
    let rating: Rating?
    let imageList: [String]?
    let image: String?
    let summary: Summary?
    let sellerEntity: SellerEntity?
    
    enum CodingKeys: String, CodingKey {
        case productIdentifier = "sku"
        case name
        case maxSavingPercentage = "max_saving_percentage"
        case price
        case specialPrice = "special_price"
        case brand, rating
        case imageList = "image_list"
        case image
        case summary
        case sellerEntity = "seller_entity"
    }
}
extension Product {
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
