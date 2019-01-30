//
//  RatingView.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

class RatingView: UIView, CodableView {
    let total: Int
    let starSize: StarSize
    
    var current: Double {
        didSet {
            if current > Double(total) || current < 0 {
                current = oldValue
            }
            var fillRate = current
            for view in stack.arrangedSubviews {
                guard let star = view as? StarView else { break }
                star.fillRate = fillRate
                fillRate -= 1
            }
        }
    }
    
    var fadedColor = UIColor.darkGray {
        didSet {
            for view in stack.arrangedSubviews {
                guard let star = view as? StarView else { break }
                star.fadedColor = fadedColor
            }
        }
    }
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.backgroundColor = .clear
        return stack
    }()
    
    init(initial: Double = 0, total: Int, starSize: StarSize = .small) {
        current = initial
        self.total = total
        self.starSize = starSize
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        for view in stack.arrangedSubviews {
            guard let star = view as? StarView else { break }
            star.tintColor = tintColor
        }
    }
    
    // MARK: Codable View
    
    func configViews() {
        tintColor = .yellow
        backgroundColor = .clear
        
        var fillRate = current
        for index in 0 ..< total {
            let star = StarView(size: starSize, fillRate: fillRate)
            stack.insertArrangedSubview(star, at: index)
            fillRate -= 1
        }
    }
    
    func buildViews() {
        addSubview(stack)
    }
    
    func configConstraints() {
        let size = starSize == .small ? 62 : 100
        stack.snp.makeConstraints {
            $0.width.equalTo(size)
        }
    }
}


