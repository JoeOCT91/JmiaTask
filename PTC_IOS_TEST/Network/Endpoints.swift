//
//  Endpoints.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var baseUrl: String { get }
}

enum MockLabsEndpoints: Endpoint {
    
    case productList(query: String, page: Int)
    case produtDetail(id: Int)
    
    var baseUrl: String {
        return "http://nd7d1.mocklab.io/"
    }
    
    var path: String {
        switch self {
        case .productList(let query, let page):
            return "search/\(query)/page/\(page)/"
        case .produtDetail(let id):
            return "product/\(id)/"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: baseUrl)?.appendingPathComponent(path)
        return URLRequest(url: url!)
    }
}

