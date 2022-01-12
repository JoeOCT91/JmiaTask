//
//  UILabel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

extension UILabel {
    
    func strikethrough(withColor strikeColor: UIColor = .red , strickWidth : Double = 1){
        let attributed = NSMutableAttributedString(string: self.text ?? "")
        let range = NSRange(location: 0, length: attributed.length)
        attributed.addAttribute(NSAttributedString.Key.strikethroughStyle , value: strickWidth, range: range)
        attributed.addAttribute(NSAttributedString.Key.strikethroughColor, value: strikeColor, range:  range)
        self.attributedText  = attributed
    }
    
}

