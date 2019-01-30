//
//  ProductListMetaDataModel.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

public struct ProductListMetaDataModel: Codable {
    public let title: String
    public let totalProducts: Int?
    public let results: [ProductResultModel]
}

