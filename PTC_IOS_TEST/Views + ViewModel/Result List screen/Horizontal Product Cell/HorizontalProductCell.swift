//
//  HorizontalProductCell.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import Cosmos


class HorizontalProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productbrand: UILabel!
    @IBOutlet weak var oldPricebrand: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productPriceDiscount: UILabel!
    @IBOutlet weak var productRating: UIView!
    @IBOutlet weak var discountBackground: UIView!
    
    lazy var view : CosmosView = {
        view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.filledBorderColor = AppColors.blackColor 
        view.settings.filledColor = AppColors.jumiaOrangeColor
        return view
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCellUI(productResult: Results){
        productPriceDiscount.text = "\(productResult.maxSavingPercentage ?? 0) %"
        productName.text = productResult.name ?? ""
        productbrand.text = productResult.brand ?? ""
        oldPricebrand.text = "\(LocalStorage.getCurrencySymbol()) \(String(describing: productResult.price ?? 0))"
        oldPricebrand.strikeThrough(true)
        productPrice.text = "\(LocalStorage.getCurrencySymbol()) \(String(describing: productResult.specialPrice ?? 0))"
        discountBackground.discountBackgroundView()
        
        view.rating = Double(productResult.ratingAverage ?? 0)
        productRating.addSubview(view)
        
        productImage.sd_setImage(with: URL(string:  productResult.image ?? "")) { (downloadedImage, downloadExeption, cacheType, downloadURL) in
            if let downloadExeption = downloadExeption{
                print("Error downloading the image: \(downloadExeption.localizedDescription)")
                self.productImage.isHidden = true
            }else{
                print("Successfully download image: \(String(describing: downloadURL?.absoluteString))")
                self.productImage.isHidden = false
            }
        }
        
    }
    
}

