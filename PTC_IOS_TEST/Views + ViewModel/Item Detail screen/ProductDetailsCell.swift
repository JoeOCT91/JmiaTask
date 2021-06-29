//
//  ProductDetailsCell.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailsCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCellUI(productImageString : String){
        productImageView.sd_setImage(with: URL(string:  productImageString ?? "")) { (downloadedImage, downloadExeption, cacheType, downloadURL) in
            if let downloadExeption = downloadExeption{
                print("Error downloading the image: \(downloadExeption.localizedDescription)")
                self.productImageView.isHidden = true
            }else{
                print("Successfully download image: \(String(describing: downloadURL?.absoluteString))")
                self.productImageView.isHidden = false
            }
        }
        
    }
  
}
