//
//  Int+Extension.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

extension Int {
    func asNSNumber() -> NSNumber {
        return self as NSNumber
    }
    
//    func asString() -> String {
//        let currencyFormatter = NumberFormatter()
//        currencyFormatter.usesGroupingSeparator = true
//        currencyFormatter.numberStyle = .currency
//        currencyFormatter.currencySymbol = ""
//        currencyFormatter.locale = Locale(identifier: "pt_BR")
//        guard let currencyString = currencyFormatter.string(from: asNSNumber()) else {
//            print("[ERROR] Problem to convert Decimal to currency from file: \(#file) \(#line)")
//            return ""
//        }
//        return currencyString
//    }
//
    func asCurrencyValue() -> String {
        let currencyFormatter = NumberFormatter()

        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "\u{20a6} "
        currencyFormatter.locale = Locale(identifier: "NGN")

        guard let brCurrencyString = currencyFormatter.string(from: asNSNumber()) else {
            print("[ERROR] Problem to convert Decimal to currency from file: \(#file) \(#line)")
            return ""
        }

        return brCurrencyString
    }
}
