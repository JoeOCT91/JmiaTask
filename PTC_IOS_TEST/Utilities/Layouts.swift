//
//  Layouts.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class Layouts {
        
    class func createTwoColumnFlowLayout () -> UICollectionViewFlowLayout {
        let width = Measurements.screenWidth
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 12
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
        flowLayout.minimumLineSpacing = minimumItemSpacing
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
    
    class func createSlideShowFlowLayout() -> UICollectionViewFlowLayout {
        let width = Measurements.screenWidth
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 12
        let availableWidth = width - (padding * 4) - minimumItemSpacing
        let itemWidth = availableWidth / 4
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
        flowLayout.minimumLineSpacing = minimumItemSpacing
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = .horizontal

        
        return flowLayout
    }

}
