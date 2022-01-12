//
//  ProductDetailsResponse.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
struct ProductDetailsResponse : Codable {
    // MARK: - Proprties
     var success : Bool = true
     var metadata : ProductDetails?
}
