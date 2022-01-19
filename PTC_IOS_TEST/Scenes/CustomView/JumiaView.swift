//
//  JumiaView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 19/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class JumiaView: UIView {
    
    private let errorView = UIView(frame: .zero)
    internal var isErrorVisible = false {
        didSet (newValue) {
            errorView.isHidden = !newValue
        }
    }
    
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    internal func setInternalErrorView() {
        self.addSubview(errorView)
        //self.errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        self.stylingInternalError()
    }
    
    private func stylingInternalError() {
        //let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        let image = UIImage(systemName: L10n.networkErrorIcon)
        let imageView = UIImageView(image: image)
        errorView.addSubview(imageView)
        imageView.anchorCenterSuperview()
        imageView.anchor(widthConstant: Measurements.screenWidth * 0.65, heightConstant: Measurements.screenWidth * 0.65)
    }
    
}
