//
//  Currency.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let iso: String
    let currencySymbol: UnicodeScalarType
    let position, decimals: Int
    let thousandsSep, decimalsSep: String

    enum CodingKeys: String, CodingKey {
        case iso
        case currencySymbol = "currency_symbol"
        case position, decimals
        case thousandsSep = "thousands_sep"
        case decimalsSep = "decimals_sep"
    }
}
