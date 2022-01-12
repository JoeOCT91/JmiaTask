//
//  Double.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/9/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation


extension Double {
    
    var toStringCurrency : String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return  formatter.string(from: self as NSNumber) ?? String(self)
    }
}
