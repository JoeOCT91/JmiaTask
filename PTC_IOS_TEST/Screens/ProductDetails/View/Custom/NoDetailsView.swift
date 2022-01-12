//
//  NoDetailsView.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/12/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

typealias AcceptAction = ()-> Void

class NoDetailsView: UIView {
    
    var message : String = "" {
        didSet {
            messageLab.text = message
        }
    }

    var messageLab : UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textAlignment = .center
         lab.numberOfLines = 5
         lab.textColor = .darkGray
         return lab
     }()
    
    var iconImageView : UIImageView = {
         let img = UIImageView()
        img.image = UIImage(named: icons.noDetailsFound.rawValue)
         return img
    }()
    
    var acceptButton : UIButton = {
           let button = UIButton()
           button.backgroundColor = .mainColor
           button.setTitle("Back To Product", for: .normal)
           button.setTitleColor(.darkGray, for: .highlighted)
           button.setTitleColor(.white, for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
           return button
       }()
    
    var acceptButtonAction : AcceptAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.white
        addSubviews(contentOf: [iconImageView , messageLab , acceptButton])
        configureUIConstrains()
        configureUIEvents()
    }
    
    func configureUIConstrains(){
        iconImageView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.width.height.equalTo(100)
            maker.centerX.equalTo(self.snp.centerX)
            maker.centerY.equalTo(self.snp.centerY).offset(-100)
            
        }
        
        messageLab.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.leading.equalTo(self).offset(15)
            maker.trailing.equalTo(self).offset(-15)
            maker.top.equalTo(iconImageView.snp.bottom).offset(25)
        }
        
        acceptButton.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.height.equalTo(40)
            maker.width.equalTo(self).multipliedBy(0.75)
            maker.centerX.equalTo(self)
            maker.top.equalTo(messageLab.snp.bottom).offset(25)
        }
    }
    
    func configureUIEvents(){
        acceptButton.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
    }
    
    @objc func  acceptTapped(){
        if acceptButtonAction != nil{
            acceptButtonAction!()
        }
    }
    
    
    

}
