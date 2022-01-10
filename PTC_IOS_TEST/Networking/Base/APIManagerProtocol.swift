//
//  APIManagerProtocol.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import Foundation

protocol APIManagerProtocol {
    
    func request<T: Codable>(endpoint : EndPoint , method : Method , params : JSON? , completion : @escaping (Result<T , ApiError>)->())
    
    func call<T : Codable>(with value : URLRequest , completion : @escaping (Result<T, ApiError>)->())
}

