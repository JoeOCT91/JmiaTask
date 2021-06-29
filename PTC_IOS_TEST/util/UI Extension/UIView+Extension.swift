//
//  UIView+Extension.swift
//  Hyperone
//
//  Created by Mostafa El-Sayed on 5/19/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import UIKit
// MARK:- IBInspectable Properties
extension UIView {

    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func setBorder(borderWidth: CGFloat = 1,
                   color: UIColor = AppColors.jumiaOrangeColor,
                   cornerRadius: CGFloat = 12) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }

    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }

}
