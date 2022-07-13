//
//  CircularProgressView.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 11.07.2022.
//

import UIKit

class CircularProgressView: UIView {
    
    private var progressLayer = CAShapeLayer()
    private var tracklayer = CAShapeLayer()
    
    private let progressColor = UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1).cgColor
    private let trackColor = UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.2).cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircularPath()
        setProgressWithAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createCircularPath()
        setProgressWithAnimation()
    }
    
    private func createCircularPath() {
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
                                      radius: frame.size.width, startAngle: .pi * 2 + 5,
                                      endAngle: -(.pi * 2 + 5), clockwise: false)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor
        tracklayer.lineWidth = 10
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
    }
    
    private func setProgressWithAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(1)
        progressLayer.add(animation, forKey: "animateCircle")
    }
    
    func stopAnimate() {
        self.layer.removeAllAnimations()
        self.layer.removeFromSuperlayer()
    }
    
}
