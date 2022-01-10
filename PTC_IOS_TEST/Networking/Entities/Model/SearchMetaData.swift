//
//  SearchMetaData.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

struct SearchMetaData : Codable {
    // MARK: - Proprties
    public var sort : String = ""
    public var total_products : Int = 0
    public var title : String = ""
    public var results : [ProductSearchItem] = []
}
