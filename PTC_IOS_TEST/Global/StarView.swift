//
//  StarsView.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

enum StarSize: Int {
    case small = 10
    case large = 20
}

class StarView: UIView {
    var fillRate: Double = 1 {
        didSet {
            if fillRate < 0 {
                fillRate = 0
            }
            if fillRate > 1 {
                fillRate = 1
            }
            shapeLayer.bounds = CGRect(origin: .zero, size: CGSize(width: Double(frame.width * 2) * fillRate, height: Double(frame.height * 2)))
            shapeLayer.path = UIBezierPath(rect: shapeLayer.bounds).cgPath
        }
    }
    
    let points: Int
    
    var fadedColor: UIColor = .darkGray {
        didSet {
            view.backgroundColor = fadedColor
        }
    }
    
    private let view = UIView()
    private let shapeLayer = CAShapeLayer()
    private let starMask = CAShapeLayer()
    
    init(size: StarSize, points: Int = 5, fillRate: Double = 1) {
        self.points = points
        self.fillRate = fillRate
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size.rawValue, height: size.rawValue)))
        setUp()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        shapeLayer.fillColor = tintColor.cgColor
    }
    
    private func setUp() {
        backgroundColor = .clear
        fadedColor = .darkGray
        tintColor = UIColor(red: 255.0 / 250.0, green: 188.0 / 250.0, blue: 0.0 / 250.0, alpha: 1.0)
        
        setUpLayers()
        addSubview(view)
    }
    
    private func setUpLayers() {
        let star = starPath()
        starMask.path = star.cgPath
        shapeLayer.bounds = CGRect(origin: .zero, size: CGSize(width: Double(frame.width * 2) * fillRate, height: Double(frame.height * 2)))
        shapeLayer.path = UIBezierPath(rect: shapeLayer.bounds).cgPath
        view.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: frame.height))
        view.layer.addSublayer(shapeLayer)
        view.layer.mask = starMask
    }
    
    private func starPath() -> UIBezierPath {
        let path = UIBezierPath()
        let starExtrusion = frame.width / CGFloat(points)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        var angle = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2 / Double(points))
        let radius = frame.width / 2
        
        for index in 1 ... points {
            let point = pointFrom(angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle + angleIncrement / 2, radius: starExtrusion, offset: center)
            if index == 1 {
                path.move(to: point)
            }
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            angle += angleIncrement
        }
        path.close()
        
        return path
    }
    
    private func pointFrom(_ angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
}

