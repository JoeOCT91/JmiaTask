//
//  ProductDetailImageTableViewCell.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 30/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

class ProductDetailImageTableViewCell: UITableViewCell {

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public var imageUrl: String? {
        didSet {
            if let urlString = imageUrl,
                let url = URL(string: urlString){
                productImageView.kf.setImage(with: url)
                setupViews()
            }
        }
    }
}

extension ProductDetailImageTableViewCell: CodableView {
    func configViews() {
        
    }
    
    func buildViews() {
        addSubview(productImageView)
    }
    
    func configConstraints() {
        productImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(250)
            $0.bottom.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(16)
        }
    }
}
