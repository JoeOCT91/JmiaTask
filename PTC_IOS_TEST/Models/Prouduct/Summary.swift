//
//  Summary.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct Summary: Codable {
    let shortDescription, summaryDescription: String

    enum CodingKeys: String, CodingKey {
        case shortDescription = "short_description"
        case summaryDescription = "description"
    }
}
