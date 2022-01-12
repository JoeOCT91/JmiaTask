//
//  EndPoint.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

public typealias JSON = [String : Any]

enum ApiError : Error{
    case serverError
    case parseError
    case internalError
    case invalidUrlError
}

enum Method : String {
    case GET
    case POST
}

enum EndPoint  {
    //Mark - API EndPoints
    case searchProducts(String, Int)
    case productDetails(Int)
   
    var path : String {
        switch self {
        case .searchProducts(let query , let page) :
            return "search/\(query)/page/\(page)/"
        case .productDetails(let sku) :
            return "product/\(sku)/"
       }
    }
}
