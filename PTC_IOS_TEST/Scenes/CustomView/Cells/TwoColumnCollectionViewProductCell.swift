//
//  TwoColumnCollectionViewProductCell.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Cosmos
import SwifterSwift

class TwoColumnCollectionViewProductCell: UICollectionViewCell {
    
    private let container = UIView(frame: .zero)
    private let viewsStack = UIStackView(frame: .zero)
    private let productImageView = UIImageView(frame: .zero)
    private let productNameLabel = JumiaLabel()
    private let productBrandLabel = JumiaLabel()
    private let priceLabel = JumiaLabel()
    private let priceBeforeLabel = JumiaLabel()
    private let ratingLabel = CosmosView(frame: .zero)
    private let addToCartButton = UIButton(frame: .zero)
    
    // Life cycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = ColorName.productCellBG.color
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        self.configureContainerView()
        self.configureViewStacks()
        self.configureViewStacks()
        self.configureAddToCartButton()
        self.configureDiscerptionLabel()
    }
    
    private func configureContainerView() {
        container.addSubview(viewsStack)
        container.cornerRadius = 12
        viewsStack.fillToSuperview()
    }
    
    func configureDiscerptionLabel() {
        self.productNameLabel.numberOfLines = 2
        
    }

    private func configureViewStacks() {
        let stackViews = [productImageView, productNameLabel, productBrandLabel, priceLabel, priceBeforeLabel, ratingLabel, addToCartButton]
        viewsStack.addArrangedSubviews(stackViews)
        viewsStack.isLayoutMarginsRelativeArrangement = true
        viewsStack.layoutMargins = EdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        viewsStack.spacing = 4
        viewsStack.axis = .vertical
    }
    
    private func configureDescriptionLabel() {
        productNameLabel.numberOfLines = 2
    }
    
    private func configureAddToCartButton() {
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addToCartButton.backgroundColor = ColorName.addToCartBGColor.color
        let config = UIImage.SymbolConfiguration(pointSize: 22)
        let image = UIImage(systemName: L10n.addToCartIcon,  withConfiguration: config)?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        addToCartButton.setImage(image, for: .normal)
        addToCartButton.setTitle(L10n.addToCart, for: .normal)
        addToCartButton.cornerRadius = 12
    }
    
    //-----------------------------------------------------------------------------------------------------
    //=======>MARK: -  Public Methods...
    //-----------------------------------------------------------------------------------------------------
    internal func populateCell(with product: Product) {
        self.productNameLabel.text = product.name
        self.productBrandLabel.text = product.brand
        guard let urlAsString = product.image else { return }
        guard let url  = URL(string: urlAsString) else { return }
        self.productImageView.download(from: url)
        

        // price after discount text
        self.priceLabel.text = "\(String(product.specialPrice)) \(UserDefaultsManager.shared().currencySymbol!)"
        // Price Before discount text
        let priceAsString = "\(String(product.price)) \(UserDefaultsManager.shared().currencySymbol!)"
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: priceAsString)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0,
                                     length: attributeString.length))
        priceBeforeLabel.attributedText = attributeString
        // rating view
        guard let rating = product.rating?.average else {
            ratingLabel.isHidden = true
            return
        }
        ratingLabel.rating = Double(rating)
    }

}
