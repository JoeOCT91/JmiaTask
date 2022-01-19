//
//  SearchResult.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

class SearchResult: Codable {
    
    let sort: String
    let totalProducts: Int
    let title: String
    let results: [Product]
    
    enum CodingKeys: String, CodingKey {
        case sort
        case totalProducts = "total_products"
        case title, results
    }
}
