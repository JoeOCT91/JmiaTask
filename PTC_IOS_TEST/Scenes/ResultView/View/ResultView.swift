//
//  ResultView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SwifterSwift

class ResultView: JumiaView {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  proprieties
    //----------------------------------------------------------------------------------------------------------------
    
    internal var collectionView: UICollectionView!
    internal var headerView = UIView(frame: .zero)
    internal var changeLayoutButton = UIButton()
    internal var popularityButton = UIButton()
    internal var filterButton = UIButton()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lifecycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    override init() {
        super.init()
        self.backgroundColor = ColorName.bgColor.color
        self.setupUI()
        self.setInternalErrorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    private func setupUI(){
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let viewLayout = Layouts.createTwoColumnFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        self.addSubview(collectionView)
        collectionView.fillToSuperview()
        collectionView.register(TwoColumnCollectionViewProductCell.self, forCellWithReuseIdentifier: Cells.TwoColumnProductCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        viewLayout.itemSize.height = 350
    }
    
}
