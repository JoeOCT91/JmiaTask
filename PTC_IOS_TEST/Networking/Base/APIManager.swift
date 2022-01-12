//
//  APIManager.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

class APIManager : APIManagerProtocol {
    
    func request<T : Codable>(endpoint: EndPoint, method: Method, params: JSON?, completion: @escaping (Result<T, ApiError>) -> ()) {
        
        let urlStr = "\(identifiers.apiUrl.rawValue)\(endpoint.path)"
        guard var urlComp = URLComponents(string: urlStr) else {
            completion(.failure(.invalidUrlError))
            return
        }
        if let body = params , method == .GET {
            urlComp.queryItems = []
            for item in body {
                let value = String(describing: item.value)
                urlComp.queryItems!.append(URLQueryItem(name: item.key, value: value))
            }
        }
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = method.rawValue
        request.addValue(identifiers.apiAccept.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(identifiers.apiAccept.rawValue, forHTTPHeaderField: "Accept")
        call(with: request, completion: completion)
        
    }
    
    func call<T : Codable>(with value: URLRequest, completion: @escaping (Result<T, ApiError>) -> ()){
       
        let task = URLSession.shared.dataTask(with: value) { data , response , error in
            guard let data = data , error == nil else {
                completion(.failure(.serverError))
                return
            }
            do {
                let info = try JSONDecoder().decode(T.self, from: data)
                completion(.success(info))
            }
            catch(let ex){
                debugPrint("\(ex)")
                completion(.failure(.parseError))
            }
        }
        
        task.resume()
    }

}
