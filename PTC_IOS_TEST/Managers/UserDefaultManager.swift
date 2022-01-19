//
//  UserDefaultManager.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var currencySymbol : String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.currencySymbol)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.currencySymbol) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.currencySymbol)!
        }
    }
    
}
