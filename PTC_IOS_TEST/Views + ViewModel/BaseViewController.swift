//
//  BaseViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 26/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import DropDown


class BaseViewController: UIViewController {
    var dropButton = DropDown()
    let baseDisposeBag = DisposeBag()
    var loadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var badgeBarButton = BadgeBarButtonItem()
        
    public func showLoadingIndicator(){
        loadingIndicator.center = self.view.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    public func stopLoadingIndicator(){
        loadingIndicator.stopAnimating()
    }
    
    public func navigateController(navigateKey : NavigationKeys){
        self.present(getNextViewContoller(navigateKey: navigateKey), animated: true, completion: nil)
    }
    
    func setupDropDownList(searchBarTextField : UITextField){
        dropButton.anchorView = searchBarTextField
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.textColor = AppColors.blackColor
        dropButton.backgroundColor = AppColors.jumiaOrangeColor
        dropButton.direction = .bottom
        DropDown.startListeningToKeyboard()
    }
    
    func CustomViewForNoDataUIView(labelText : String, subLabelText : String = "" , imageIcone : UIImage){
        let image = UIImageView(frame: CGRect(x: view.frame.size.width / 2 - 75 ,
                                              y: view.frame.size.height / 2 - 150 ,
                                              width: 150,
                                              height: 150))
        image.tag = 100211
        let label = UILabel(frame: CGRect(x: image.frame.minX - 50,
                                          y: image.frame.maxY - 25,
                                          width: 250,
                                          height: 150))
        label.tag = 200212
        
        let subLabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - 150,
                                             y: label.frame.maxY - 25,
                                             width: 300,
                                             height: 30))
        
        if let viewWithTag = self.view.viewWithTag(100211) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = self.view.viewWithTag(200212) {
            viewWithTag.removeFromSuperview()
        }
        
        
        if !labelText.isEmpty{
            image.image = imageIcone
            image.contentMode = UIView.ContentMode.scaleAspectFit
            self.view.addSubview(image)
            label.text = labelText
            label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = AppColors.jumiaOrangeColor
            self.view.addSubview(label)
            
            if subLabelText != ""{
            subLabel.text = subLabelText
                subLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            subLabel.numberOfLines = 1
            subLabel.textAlignment = .center
            subLabel.textColor = AppColors.jumiaOrangeColor
            self.view.addSubview(subLabel)
            }
        }
    }
}
