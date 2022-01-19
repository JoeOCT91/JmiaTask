//
//  JumiaLabel.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 17/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

@IBDesignable
class JumiaLabel: UILabel {
    
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
    
    @IBInspectable
    var paddingLeft: CGFloat {
        set { textEdgeInsets.left = newValue }
        get { return textEdgeInsets.left }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        set { textEdgeInsets.right = newValue }
        get { return textEdgeInsets.right }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        set { textEdgeInsets.top = newValue }
        get { return textEdgeInsets.top }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        set { textEdgeInsets.bottom = newValue }
        get { return textEdgeInsets.bottom }
    }
    @IBInspectable
    var byInsets: UIEdgeInsets {
        set { textEdgeInsets = newValue }
        get { return textEdgeInsets }
    }
    

    private let LabelFont = UIFont(font: FontFamily.Nunito.bold, size: FontSize.regular)
    
    init(title: String = String(), alignment : NSTextAlignment = .left, fontSize: CGFloat = FontSize.regular) {
        super.init(frame: .zero)
        setupUI()
        self.text = title
        self.font = LabelFont?.withSize(fontSize)
        self.textAlignment = alignment
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.textColor = ColorName.blackColor.color
    }
    
    func withCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
}



