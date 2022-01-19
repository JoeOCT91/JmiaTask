//
//  Constants.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Api Urls end points
struct URLs {
    static let base = "http://nd7d1.mocklab.io/"
    static let configurations = "configurations/"
    static let search = "search/"
    static let product =  "product/"
}

//MARK: - Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let accept = "accept"
}

//MARK: - UserDefaults Keys
struct UserDefaultsKeys {
    static let currencySymbol = "CurrencySymbol"
}

struct Cells {
    static let TwoColumnProductCell = "TwoColumnCollectionViewProductCell"
    static let oneColumnProductCell = "OneColumnCollectionViewProductCell"
    static let slideShowCell = "SlideShowCell"
}

struct Measurements {
    static let screenWidth = UIScreen.main.bounds.width
}

struct FontSize {
    static let small: CGFloat = 12
    static let regular: CGFloat = 14
    static let medium: CGFloat = 16
    static let large: CGFloat = 18
}
