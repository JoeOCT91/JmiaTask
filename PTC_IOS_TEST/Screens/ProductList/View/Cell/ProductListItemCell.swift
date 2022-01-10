//
//  ProductListItemCell.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/5/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SnapKit
import Cosmos
import Kingfisher

class ProductListItemCell: UICollectionViewCell {
    
    var pictureView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.kf.indicatorType = .activity
        return img
    }()
    
    var brandLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .lightGray
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    var nameLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.numberOfLines = 2
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        return lab
    }()
    
    var priceLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .gray
        return lab
    }()
    
    var specialPriceLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        return lab
    }()
    
    var discountPercentLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .orange
        lab.layer.borderWidth = 0.5
        lab.layer.borderColor = UIColor.orange.cgColor
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    
    var ratingView : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.isUserInteractionEnabled = false
        cosmos.settings.emptyBorderColor = .lightGray
        cosmos.settings.filledColor = .yellow
        return cosmos
    }()
    
   lazy var mainStack  : UIStackView =  {
      let stack = UIStackView(arrangedSubviews: [pictureView , brandLabel , nameLabel , specialPirceStack , priceLabel , ratingView ])
      stack.axis = .vertical
      stack.spacing = 10
      return stack
   }()
    
    lazy var specialPirceStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [ specialPriceLabel , discountPercentLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    var containerView : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configureUI(){
        contentView.addSubview(containerView)
        containerView.addSubview(mainStack)
    }
    
    func configureConstraints(){
        containerView.snp.makeConstraints { maker in
            maker.top.leading.equalTo(contentView).offset(4)
            maker.trailing.bottom.equalTo(contentView).offset(-4)
        }
        mainStack.snp.makeConstraints { maker in
            maker.top.leading.equalTo(containerView).offset(4)
            maker.trailing.equalTo(containerView).offset(-4)
            maker.bottom.equalTo(containerView)
        }
        pictureView.snp.makeConstraints { maker in
            maker.height.equalTo(mainStack.snp.height).multipliedBy(0.45).priority(750)
        }
        ratingView.snp.makeConstraints { maker in
            maker.height.equalTo(25)
        }
    }
    
    func setup(with item : ProductViewData){
        brandLabel.text = item.brand
        nameLabel.text = item.name
        priceLabel.text = item.price
        specialPriceLabel.text = item.specialPrice
        discountPercentLabel.text = item.savingPercentage
        ratingView.rating = Double(item.ratingAverage)
        priceLabel.strikethrough()
        if let url = URL(string: item.image) {
          pictureView.kf.setImage(with: url)
        }
        //else display a no image available
    }
}
