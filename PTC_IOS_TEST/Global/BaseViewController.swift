//
//  BaseViewController.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

public class BaseViewController: UIViewController {
    
    public let emptyStateView = EmptyStateView()
    
    override public func viewDidLoad() {
        emptyStateView.delegate = self
    }
    
    override public func viewWillLayoutSubviews() {
        view.backgroundColor = .white
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        hideLoad()
    }
    
    public func showLoad() {
        SVProgressHUD.show()
    }
    
    public func hideLoad() {
        SVProgressHUD.dismiss()
    }
}

extension BaseViewController: EmptyStateViewDelegate {
    public func didTapTryAgain() {
        navigationController?.popViewController(animated: true)
    }
}
