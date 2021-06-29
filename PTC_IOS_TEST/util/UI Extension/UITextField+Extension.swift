//
//  UITextField+Extension.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 5, y: 0, width: self.frame.height/2, height: self.frame.height/2))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 5, y: 0, width: self.frame.height/2 + 5, height: self.frame.height/2))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = AppColors.blackColor
    }
}
