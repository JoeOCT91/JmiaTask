//
//  ProducListTableViewCell.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit
import Kingfisher

//Image;
//Name and brand;
//Price, old price and discount;
//Rating;

class ProductListCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let newPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    private var ratingView: RatingView = {
        let view = RatingView(initial: 0, total: 5, starSize: .small)
        return view
    }()
    
    private let priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    var cellLayout: ProductResultModel? {
        didSet {
            if let cell = cellLayout {
                if let image = cell.image,
                    let url = URL(string: image) {
                    productImageView.kf.setImage(with: url)
                }
                
                brandLabel.text = cell.brand
                nameLabel.text = cell.name
                newPriceLabel.text = "\(cell.specialPrice.asCurrencyValue())"
                discountLabel.text = "- \(cell.maxSavingPercentage)%"
                oldPriceLabel.text = "\(cell.price.asCurrencyValue())"
                ratingView.current = Double(cell.ratingAverage ?? 0)
                
                setupViews()
            }
        }
    }
}

extension ProductListCollectionViewCell: CodableView {
    func configViews() {
        
    }
    
    func buildViews() {
        addSubview(productImageView)
        addSubview(contentStackView)
        addSubview(priceStackView)
        
        priceStackView.addArrangedSubview(newPriceLabel)
        priceStackView.addArrangedSubview(discountLabel)
        
        contentStackView.addArrangedSubview(brandLabel)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(priceStackView)
        contentStackView.addArrangedSubview(oldPriceLabel)
        contentStackView.addArrangedSubview(ratingView)
    }
    
    func configConstraints() {
        productImageView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(80)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(productImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
}
