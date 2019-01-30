//
//  ProductDetailSizeTableViewCell.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import Foundation

class ProductDetailPriceTableViewCell: UITableViewCell {
    
    private var newPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private var discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private var priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    var cellLayout: ProductResultModel? {
        didSet {
            if let cell = cellLayout {
                newPriceLabel.text = "\(cell.specialPrice.asCurrencyValue())"
                discountLabel.text = "- \(cell.maxSavingPercentage)%"
                oldPriceLabel.text = "\(cell.price.asCurrencyValue())"
                setupViews()
            }
        }
    }
}

extension ProductDetailPriceTableViewCell: CodableView {
    func configViews() {
        
    }
    
    func buildViews() {
        addSubview(priceStackView)
        priceStackView.addArrangedSubview(newPriceLabel)
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(discountLabel)
    }
    
    func configConstraints() {
        priceStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    
}
