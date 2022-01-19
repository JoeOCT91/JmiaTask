//
//  ResultView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SwifterSwift

class ResultView: UIView {
    
    internal var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = ColorName.bgColor.color
        self.setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        internal func setupUI(){
            configureCollectionView()
        }
        
        func configureCollectionView() {
            let viewLayout = Layouts.createTwoColumnFlowLayout()
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
            self.addSubview(collectionView)
            collectionView.fillToSuperview()
            collectionView.register(TwoColumnCollectionViewProductCell.self, forCellWithReuseIdentifier: Cells.TwoColumnProductCell)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .clear
            viewLayout.itemSize.height = 500
            
        }
        
}
