//
//  ProductsListSearchResponse.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

struct ProductsListSearchResponse : Codable {
    // MARK: - Proprties
     var success: Bool = true
     var metadata : SearchMetaData? = nil
}
