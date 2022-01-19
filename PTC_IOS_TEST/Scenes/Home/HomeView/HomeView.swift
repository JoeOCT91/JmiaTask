//
//  HomeView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class HomeView: JumiaView {
    
    override init(){
        super.init()
        self.setupView()
        self.setInternalErrorView()
        isErrorVisible = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = ColorName.bgColor.color
    }
    
    


}
