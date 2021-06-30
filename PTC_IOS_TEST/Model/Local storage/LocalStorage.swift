//
//  LocalStorage.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 26/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation

struct Keys {
    static let currencySymbol = "currencySymbol"
    static let searchHistory = "searchHistory"
}

public struct LocalStorage{
    
    static func saveCurrencySymbol(currency : Currency?){
        UserDefaults.standard.set(currency?.currencySymbol, forKey: Keys.currencySymbol)
    }
    
    static func saveSearchHistory(searchHistory: [String]? ){
        UserDefaults.standard.set(searchHistory , forKey: Keys.searchHistory)
    }
    
    static func getCurrencySymbol()->String{return checkIfEmptyorNil(check: UserDefaults.standard.string(forKey: Keys.currencySymbol))}
    
    static func getSearchHistory()-> [String]{return UserDefaults.standard.object(forKey: Keys.searchHistory) as? [String] ?? []}
    
    static func checkIfEmptyorNil(check : String?)-> String {
        guard let myCheck = check, !myCheck.isEmpty , myCheck != "null" else {
            return ""
        }
        return myCheck
    }
}
