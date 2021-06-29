//
//  TestCollectionViewCell.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import SDWebImage
import Shimmer

class HorizontalProductCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCellUI(productResult: Results){
        productName.text = productResult.name ?? ""
        productPrice.text = "\(LocalStorage.getCurrencySymbol()) \(String(describing: productResult.specialPrice ?? 0))"
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
