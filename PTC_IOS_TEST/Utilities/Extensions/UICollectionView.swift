//
//  UICollectionView.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/7/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SnapKit

extension UICollectionView {
    func setMessage(_ message : String , icon : String = icons.sysProblem.rawValue){
        
        let view = UIView()
        self.backgroundView = view
        
        let msgLabel = UILabel()
        msgLabel.textAlignment = .center
        msgLabel.textColor = .lightGray
        msgLabel.numberOfLines = 2
        msgLabel.lineBreakMode = .byTruncatingMiddle
        msgLabel.text = message
        view.addSubview(msgLabel)

        let imgView  = UIImageView()
        if #available(iOS 13.0, *) {
            imgView.image = UIImage(systemName: icon)!
        } else {
            imgView.image = UIImage(named: icons.problem.rawValue)!
        }
        imgView.tintColor = .lightGray
        imgView.contentMode = .scaleAspectFit
        view.addSubview(imgView)
        
        imgView.snp.makeConstraints { maker in
            maker.width.height.equalTo(50)
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-75)
        }
        
        msgLabel.snp.makeConstraints { maker in
            maker.height.equalTo(60)
            maker.leading.equalTo(view.snp.leading).offset(10)
            maker.trailing.equalTo(view.snp.trailing).offset(-10)
            maker.top.equalTo(imgView.snp.bottom).offset(10)
        }
    }
    
    
    
    func setupLoadingIndicator(){
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.color = .orange
        indicator.hidesWhenStopped = true
        backgroundView = indicator
    }
}
