//
//  NetworkRouter.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import Alamofire

struct URLS {
    static let BASE_URL = "http://nd7d1.mocklab.io"
    static let URL_Configurations = "\(BASE_URL)/configurations/"
    static let URL_Search = "\(BASE_URL)/search/%@/page/%d/"
    static let URL_Product = "\(BASE_URL)/product/%@/"
    
}

class NetworkRouter{
    enum AuthenticationRouter: URLRequestConvertible {
        
        case configurations
        case search(query : String, pageNumber : Int)
        case product(sku : String)
        
        func asURLRequest() throws -> URLRequest {
            let url:URL = {
                switch self {
                case .configurations:
                    return URL(string: URLS.URL_Configurations)!
                case .search(let query, let pageNumber):
                    return URL(string: String(format: URLS.URL_Search, query, pageNumber))!
                case .product(let sku):
                    return URL(string: String(format: URLS.URL_Product, sku))!
                    
                }
            }()
            
            let method : HTTPMethod = {
                switch self {
                case .configurations,
                     .search,
                     .product:
                    
                    return .get
                }
            }()
            
            let parameters:[String:Any]? = {
                switch self{
                case .configurations:
                    return  nil
                    
                case .search(_ ,_):
                    return nil
                    
                case .product:
                    return nil
                }
            }()
            
            var urlRequest : URLRequest {
                switch self {
                case .configurations,
                     .search,
                     .product:
                
                    return try! URLRequest(url: url,method: method)
                }
            }
            
            let encoding : ParameterEncoding = JSONEncoding.default
            return try! encoding.encode(urlRequest, with: parameters)
            
        }
    }
}
