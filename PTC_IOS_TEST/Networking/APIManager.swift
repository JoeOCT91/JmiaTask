//
//  APIManager.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Alamofire
import Combine

class APIManager {
    
    class func getConfiguration() -> AnyPublisher<DataResponse<APIMainResponse<Configuration>, JumiaError>, Never> {
        return request(APIRouter.getConfiguration)
    }
    
    class func searchFor(product: String, page: Int) -> AnyPublisher<DataResponse<APIMainResponse<SearchResult>, JumiaError>, Never> {
        return request(APIRouter.searchFor(product, page))
    }
    
    class func getProductInformation(identifier: String) -> AnyPublisher<DataResponse<APIMainResponse<Product>, JumiaError>,Never> {
        return request(APIRouter.getProduct(identifier))
    }
}

extension APIManager{
    
    enum JumiaError: Error {
    case InternalError404
    case networkError(_ error: AFError)
    }

    // MARK:- The request function to get results as publisher
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> AnyPublisher<DataResponse<T, JumiaError>, Never> {
        return AF.request(urlConvertible)
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    
                    if response.response?.statusCode == 404 {
                        let error = JumiaError.InternalError404
                        return error
                    }
                    return JumiaError.networkError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

