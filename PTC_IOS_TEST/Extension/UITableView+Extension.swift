//
//  UITableView+Extension.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

extension UITableView {
    
    func configureTableView(viewController: UIViewController, estimateRowHeight: CGFloat) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimateRowHeight
        self.separatorStyle = .singleLine
        self.tableFooterView = UIView()
        self.delegate = viewController as? UITableViewDelegate
        self.dataSource = viewController as? UITableViewDataSource
    }
}
