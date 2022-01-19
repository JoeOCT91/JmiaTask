//
//  Rating.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct Rating: Codable {
    let average, ratingsTotal: Int

    enum CodingKeys: String, CodingKey {
        case average
        case ratingsTotal = "ratings_total"
    }
}
