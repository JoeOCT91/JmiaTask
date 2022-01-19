//
//  UINAvigationController+CustomApperance.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 14/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

// This extension to custom the nav bar styling properties

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.customAppearance()
    }
    
    private func customAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorName.navBarBGColor.color
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
