//
//  ResultVC.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit


class ResultVC: UIViewController {
    
    private var viewModel: ResultVM!
    
    class func createResult() -> ResultVC {
        let resultVC = ResultVC()
        let viewModel = ResultVM()
        resultVC.viewModel = viewModel
        return resultVC
    }
    
}
