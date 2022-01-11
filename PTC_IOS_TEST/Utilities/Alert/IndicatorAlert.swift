//
//  CustomAlert.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/11/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class IndicatorAlert : BaseAlert {
    
    var activityInidicatorView :  UIActivityIndicatorView = {
        let item = UIActivityIndicatorView()
        item.hidesWhenStopped = true
        item.color = UIColor.white
        return item
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        configureContainerView()
        containerView.addSubview(activityInidicatorView)
        configureUIConstrains()
        activityInidicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    
    func configureUIConstrains(){
        containerView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.width.equalTo(self.snp.width).multipliedBy(0.2)
            maker.height.equalTo(self.snp.height).multipliedBy(0.08)
            maker.centerX.centerY.equalTo(self)
        }
        
        activityInidicatorView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.centerX.centerY.equalTo(self.containerView)
        }
    }
    
    override func show() {
        super.show()
        activityInidicatorView.startAnimating()
    }
    
    override func hide() {
        super.hide()
        activityInidicatorView.stopAnimating()
    }
    
    

}
