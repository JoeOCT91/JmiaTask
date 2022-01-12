//
//  SplashViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/11/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class SplashViewController: UIViewController {
    
    var inidicatorView :  MDCActivityIndicator = {
        let item = MDCActivityIndicator()
        item.tintColor = .mainColor
        item.radius = 20
        item.cycleColors = [.mainColor]
        return item
    }()
    
    var logoImageView : UIImageView = {
         let img = UIImageView()
         img.image = UIImage(named: "porto")
         img.contentMode = .scaleAspectFit
         return img
    }()
    
    weak var coordinator : MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        congifureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        routeToSearchScreen()
    }
    
    func congifureUI(){
        view.backgroundColor = UIColor.white
        view.addSubviews(contentOf: [logoImageView , inidicatorView])
        congifureUIConstrains()
        //inidicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)

     
    }
    
    func congifureUIConstrains(){
        logoImageView.snp.makeConstraints { maker in
            maker.width.equalTo(view).multipliedBy(0.75)
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-50)

        }
        inidicatorView.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.centerX.equalTo(self.view)
        }
    }
    
    func routeToSearchScreen(){
        inidicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {[weak self] in
            self?.coordinator?.showSearch()
        }
    }

}
