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
}

public struct LocalStorage{
    
    static func saveCurrencySymbol(configurationsDataResult : ConfigurationsDataResult){
        UserDefaults.standard.set(configurationsDataResult.currency?.currencySymbol, forKey: Keys.currencySymbol)
    }
    
    static func getCurrencySymbol()->String{return checkIfEmptyorNil(check: UserDefaults.standard.string(forKey: Keys.currencySymbol))}
    
    
    static func checkIfEmptyorNil(check : String?)-> String {
        guard let myCheck = check, !myCheck.isEmpty , myCheck != "null" else {
            return ""
        }
        return myCheck
    }
}
