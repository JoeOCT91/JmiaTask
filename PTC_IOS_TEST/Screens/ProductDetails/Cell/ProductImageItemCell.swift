//
//  ProductImageItemCell.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/9/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ProductImageItemCell: UICollectionViewCell {
    
    var pictureView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .gray
        return img
    }()
    /* I dont want to use img.kf.indicator because there is an issue  */
    var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var urlImage : URL?
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 2 : 1
            contentView.layer.borderColor = isSelected ?  UIColor.orange.cgColor :  UIColor.lightGray.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configureUI()  {
        contentView.addSubview(pictureView)
        contentView.addSubview(loadingIndicator)
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
    }

    
    func configureConstraints()  {
        pictureView.snp.makeConstraints { maker in
            maker.width.height.equalTo(contentView.snp.height)
           .multipliedBy(0.90)
            maker.centerX.centerY.equalTo(contentView)
        }
        loadingIndicator.snp.makeConstraints { maker in
            maker.width.height.equalTo(20)
            maker.centerX.centerY.equalTo(contentView)
        }
    }
    
    func setup(with urlImg : String){
        urlImage = URL(string: urlImg)
        guard let url = urlImage else {
            return
        }
        pictureView.kf.setImage(with: url , completionHandler: { res in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
            self.pictureView.backgroundColor = .none
        })
        self.loadingIndicator.startAnimating()
    }
    
    
    
}
    
