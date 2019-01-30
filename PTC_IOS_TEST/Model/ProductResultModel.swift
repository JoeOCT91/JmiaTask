//
//  ProductResultModel.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

public struct ProductResultModel: Codable {
    
    public let sku: String
    public let name: String
    public let brand: String
    public let maxSavingPercentage: Int
    public let price: Int
    public let specialPrice: Int
    public let image: String?
    public let ratingAverage: Int?
    public let rating: ProductDetailRatingModel?
    public let imageList: [String]?
    public let summary: ProductDetailSummaryModel?
}
