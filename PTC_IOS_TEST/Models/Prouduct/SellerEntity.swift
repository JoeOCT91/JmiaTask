//
//  Seller.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct SellerEntity: Codable {
    let id: Int
    let name, deliveryTime: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case deliveryTime = "delivery_time"
    }
}
