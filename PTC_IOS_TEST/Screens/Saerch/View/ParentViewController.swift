//
//  ViewController.swift
//  PTC_IOS_TEST
//
//  Created by Tiago Valente on 27/06/2019.
//  Copyright © 2019 Jumia. All rights reserved.
//

import UIKit

class ParentViewController : UIViewController {

    var infoAlert : InfoAlert?
    
    var indicatorAlert : IndicatorAlert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureInfoAlert(){
        self.infoAlert = InfoAlert()
        self.infoAlert?.onCompletedHideAction = { [weak self] in
            self?.infoAlert = nil
        }
    }
    
    func configureIndicatorAlert(){
        indicatorAlert = IndicatorAlert()
        self.indicatorAlert?.onCompletedHideAction = { [weak self] in
            self?.indicatorAlert = nil
        }
    }

}

