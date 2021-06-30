//
//  NetworkManger.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 24/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class NetworkManger {
    
    //MARK:- configurations Request Requests
    static func configurationsRequest<T: Mappable>(completion: @escaping(_ dataResult: DataResult<T>) -> Void){
        APICall(request: NetworkRouter.AuthenticationRouter.configurations, class: T.self, completion: completion)
    }
    
    //MARK:- search Request Requests
    static func searchRequest<T: Mappable>(query : String, pageNumber: Int, completion: @escaping(_ dataResult: DataResult<T>) -> Void){
        APICall(request: NetworkRouter.AuthenticationRouter.search(query: query, pageNumber: pageNumber),class: T.self, completion: completion)
    }
    
    //MARK:- product Request Requests
    static func productRequest<T: Mappable>(sku : String ,completion: @escaping(_ dataResult: DataResult<T>) -> Void){
        APICall(request: NetworkRouter.AuthenticationRouter.product(sku : sku),class: T.self, completion: completion)
    }
    
    
    private static func APICall<T: Mappable,D>(request: NetworkRouter.AuthenticationRouter, class : T.Type, completion: @escaping(_ dataResult: DataResult<D>) -> Void){
        AF.request(request).validate(statusCode: 200 ..< 201 ).responseJSON  { response in
            switch response.result{
            case .success(let value):
                guard let baseResponse: BaseResponse<T> = {
                    return BaseResponse<T>(JSON:(value as? [String:Any])!)
                }()
                else {
                    completion(errorFunction(errorMessage: "",errorReason: "",errorType: .CONNECTION_ERROR))
                    return
                }
                if baseResponse.success == false {
                    completion(errorFunction(errorMessage: baseResponse.error?.errorMessage(),errorReason: baseResponse.error?.errorReaseon(),errorType: .SERVER_ERROR))
                }else {
                    completion(DataResult.Success(data: (baseResponse.data) as? D))
                }
            case .failure( _):
                completion(errorFunction(errorMessage: "",errorReason: "",errorType: .CONNECTION_ERROR))
            }
        }
    }
    
    private static func errorFunction<T>(errorMessage: String?, errorReason: String?, errorType : DataResult<T>.ErrorType)-> DataResult<T>{
        return DataResult.Error(errorMessage: errorMessage, errorReason: errorReason, errorType: errorType)
    }
}
