//
//  APIRouter.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    private var path: String {
        switch self {
        default:
            break
        }
    }
    
    func asURLRequest() throws -> URLRequest {

        var urlComponents = URLComponents(string: URLs.base + path)!
//        if let queries = query {
//            //urlComponents.queryItems = queries
//        }
        let url =  try urlComponents.asURL()
        var urlRequest = URLRequest(url: url)
//
//        //Set request Method
//        urlRequest.httpMethod = method.rawValue
//
//        //Append Http Headers to urlRequest
//        setUrlHeaders(urlRequest: &urlRequest)
//
//        //Append Http Body to urlRequest
//        setURLBody(urlRequest: &urlRequest)
//
//        // Encoding
//        let encoding: ParameterEncoding = {
//            switch method {
//            case .get, .delete:
//                return URLEncoding.default
//            default:
//                return JSONEncoding.default
//            }
//        }()
//        print("URL Request information #######")
//        //print("\(urlRequest.httpMethod ?? "") \(String(describing: urlRequest.url))")
//        print(try encoding.encode(urlRequest, with: parameters))
//        let str = String(decoding: (urlRequest.httpBody ?? Data()), as: UTF8.self)
//        print("BODY: \n \(str)")
//        //print("HEADERS: \n \(String(describing: urlRequest.allHTTPHeaderFields))")
//        return try encoding.encode(urlRequest, with: parameters)
        return URLRequest(url: URL(fileURLWithPath: ""))
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

