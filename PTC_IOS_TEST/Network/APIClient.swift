//
//  APIClient.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//


import Foundation

enum Either<T> {
    case success(T)
    case error(APIError)
}

enum APIError: Error {
    case unknown
    case apiError
    case badResponse
    case jsonDecoder
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Codable>(with request: URLRequest, completion: @escaping (Either<T>) -> Void)
}

extension APIClient {
    
    var session: URLSession {
        return URLSession.shared
    }
    
    func fetch<T: Codable>(with request: URLRequest, completion: @escaping (Either<T>) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(.badResponse))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let value = try? decoder.decode(T.self, from: data!) else {
                completion(.error(.jsonDecoder))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        task.resume()
    }
}

