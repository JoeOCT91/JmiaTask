//
//  JumiaView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 19/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class JumiaView: UIView {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  proprieties
    //----------------------------------------------------------------------------------------------------------------

    private let errorView = UIView(frame: .zero)
    private let errorImageView = UIImageView(frame: .zero)
    private let errorLabel = JumiaLabel(alignment: .center, fontSize: FontSize.medium)
    
    internal var isErrorVisible = false {
        willSet (newValue) {
            errorView.isHidden = !newValue
        }
    }
    
    internal var errorText: String =  "" {
        willSet(newValue) {
            self.errorLabel.text = newValue
        }
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lifecycle methods
    //----------------------------------------------------------------------------------------------------------------

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Public methods
    //----------------------------------------------------------------------------------------------------------------

    internal func setInternalErrorView() {
        self.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        self.stylingInternalError()
        self.configureErrorLabel()
        self.errorView.isHidden = true
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private Methods
    //----------------------------------------------------------------------------------------------------------------
    private func stylingInternalError() {
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .thin)
        let image = UIImage(systemName: L10n.networkErrorIcon, withConfiguration: config)?.withTintColor(ColorName.addToCartBGColor.color)
                            .withRenderingMode(.alwaysOriginal)
        errorImageView.image = image
        errorView.addSubview(errorImageView)
        errorImageView.anchorCenterSuperview()
        errorImageView.anchor(widthConstant: Measurements.screenWidth * 0.65, heightConstant: Measurements.screenWidth * 0.65)
    }

    private func configureErrorLabel() {
        errorView.addSubview(errorLabel)
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 12).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 24).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -24).isActive = true
    }
    
}
