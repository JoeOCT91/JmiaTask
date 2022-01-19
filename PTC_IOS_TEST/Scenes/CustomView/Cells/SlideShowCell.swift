//
//  SlideShowCell.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 19/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class SlideShowCell: UICollectionViewCell {
    
    let productImage = UIImageView(frame: .zero)
    
    // Life cycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setImageWith(url: String){
        guard let url = URL(string: url) else { return }
        productImage.download(from: url)
    }
}
