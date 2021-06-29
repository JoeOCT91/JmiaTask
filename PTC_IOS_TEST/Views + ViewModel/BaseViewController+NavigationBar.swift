//
//  BaseViewController+NavigationBar.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 28/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//
import Foundation
import UIKit

extension BaseViewController{
    
    public func setupNavigationBarUI(isHomePage : Bool){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = AppColors.jumiaOrangeColor
        navigationController?.navigationBar.tintColor = AppColors.blackColor
        if isHomePage{
            setNavigationItem(image: #imageLiteral(resourceName: "jumia logo"),
                              imageFrameSize: .init(width: 120, height: 30))
            addCartNavigationBarLeadingItem()
        }else{
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        }
    }
    //navigation controller go back
    @objc func back() {
        self.navigationController?.popViewController(animated: false)
    }
    
    // adding logo image to navigation bar
    func setNavigationItem(image: UIImage, imageFrameSize: CGSize) {
        let imageView = UIImageView(image: image)
        let titleView = UIView(frame: .init(origin: .zero,
                                            size: .init(width: UIScreen.main.bounds.width/2,
                                                        height: 44)))
        imageView.frame.origin = .init(x: (UIScreen.main.bounds.width/4) - (imageFrameSize.width/2),
                                       y: (44/2) - (imageFrameSize.height/2))
        imageView.frame.size =  imageFrameSize
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
    }
    
    //adding cart image
    func addCartNavigationBarLeadingItem(badgeBackgroundColor: UIColor = AppColors.whiteColor,
                                         badgeTextColor: UIColor = AppColors.jumiaOrangeColor) {
        badgeBarButton.addTarget(self, action: #selector(cartNavBarButtonItemTapped), for: .touchUpInside)
        badgeBarButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        badgeBarButton.setImage(#imageLiteral(resourceName: "cart").withRenderingMode(.alwaysTemplate), for: .normal)
        badgeBarButton.badgeBackgroundColor = badgeBackgroundColor
        badgeBarButton.badgeTextColor = badgeTextColor
        addLeadingBarButtonItem(barButtonItem: UIBarButtonItem(customView: badgeBarButton))
    }
    
    @objc func cartNavBarButtonItemTapped() {
        // go to cart
    }
    
    func addLeadingBarButtonItem(barButtonItem: UIBarButtonItem) {
        var items = navigationController?.navigationItem.rightBarButtonItems ?? []
        items.append(barButtonItem)
        self.navigationItem.rightBarButtonItems = items
    }
}


