//
//  ProductDetailTextTableViewCell.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

enum ProductDetailTextCellType {
    case brand
    case description
}

class ProductDetailTextTableViewCell: UITableViewCell {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .justified
        return label
    }()
    
    var cellLayout: (text: String?, type: ProductDetailTextCellType)? {
        didSet {
            if let cell = cellLayout {
                descriptionLabel.text = cell.text
                descriptionLabel.textColor = cell.type == .brand ? .lightGray : .black
                setupViews()
            }
        }
    }
}

extension ProductDetailTextTableViewCell: CodableView {
    func configViews() {
    }
    
    func buildViews() {
        addSubview(descriptionLabel)
    }
    
    func configConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
