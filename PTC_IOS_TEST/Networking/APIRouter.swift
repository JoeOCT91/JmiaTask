//
//  APIRouter.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getConfiguration
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .getConfiguration:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getConfiguration:
            return URLs.configurations
        }
    }
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {

        let urlComponents = URLComponents(string: URLs.base + path)!
//        if let queries = query {
//            //urlComponents.queryItems = queries
//        }
        let url =  try urlComponents.asURL()
        var urlRequest = URLRequest(url: url)

        //Set request Method
        urlRequest.httpMethod = method.rawValue
//
        //Append Http Headers to urlRequest
        setUrlHeaders(urlRequest: &urlRequest)
//
//        //Append Http Body to urlRequest
//        setURLBody(urlRequest: &urlRequest)
//
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension APIRouter {
    private func setUrlHeaders(urlRequest: inout URLRequest) {
        switch self {
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)
    }
}

