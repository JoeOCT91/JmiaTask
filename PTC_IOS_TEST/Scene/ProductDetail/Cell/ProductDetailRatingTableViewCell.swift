//
//  ProductDetailRatingTableViewCell.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

class ProductDetailRatingTableViewCell: UITableViewCell {
    
    private let ratingView: RatingView = {
        let view = RatingView(initial: 0, total: 5, starSize: .large)
        return view
    }()
    
    private let totalRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor.blue
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    var cellLayout: ProductDetailRatingModel? {
        didSet {
            if let cell = cellLayout {
                ratingView.current = Double(cell.average ?? 0)
                if let total = cell.ratingsTotal {
                    totalRatingLabel.text = "(\(total)) \(R.string.localizable.productDetailRatings())"
                }
                setupViews()
            }
        }
    }
}

extension ProductDetailRatingTableViewCell: CodableView {
    func configViews() {
        
    }
    
    func buildViews() {
        addSubview(ratingStackView)
        ratingStackView.addArrangedSubview(ratingView)
        ratingStackView.addArrangedSubview(totalRatingLabel)
    }
    
    func configConstraints() {
        ratingStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    
}
