//
//  BagdeBarItemButton.swift
//  El-Araby
//
//  Created by Nesreen Mamdouh on 6/17/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import UIKit

public class BadgeBarButtonItem: UIButton {
    var badgeLabel = UILabel()

    var badge: String? {
        didSet {
            addBadgeToButton(badge: badge)
        }
    }

    public var badgeBackgroundColor: UIColor = .white {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }

    public var badgeTextColor = UIColor.orange {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }

    public var badgeFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }

    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            addBadgeToButton(badge: badge)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBadgeToButton(badge: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBadgeToButton(badge: nil)
        fatalError("init(coder:) has not been implemented")
    }

    func addBadgeToButton(badge: String?) {
        badgeLabel.text = badge
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.sizeToFit()
        badgeLabel.textAlignment = .center

        let height = 21
        let width = 21

        let xValue = 44-21
        let yValue = 0
        badgeLabel.frame = CGRect(x: xValue,
                                  y: yValue,
                                  width: width,
                                  height: height)

        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        badgeLabel.isHidden = badge != nil ? false : true
    }
}
