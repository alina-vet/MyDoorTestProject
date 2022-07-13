//
//  LeftLoadingImageView.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 11.07.2022.
//

import UIKit

class LeftLoadingImageView: UIImageView {

    private var imageShield: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shieldUnlockingImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let lay = CAReplicatorLayer()
    private let circle = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        showDotsInImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        showDotsInImageView()
    }
    
    private func configure() {
        addSubview(imageShield)
        imageShield.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(18)
        }
    }
    
    private func showDotsInImageView() {
        let layWidth = 11
        lay.frame = CGRect(x: Int(imageShield.center.x) + layWidth, y: Int(imageShield.center.y) + 20, width: layWidth, height: layWidth / 2)
        
        circle.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.white.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(8, 0, 0)
                
        imageShield.layer.addSublayer(lay)
    }
    
    func animate() {
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        self.layer.isHidden = false
    }
    
    func stopAnimate() {
        self.layer.removeAllAnimations()
        self.layer.isHidden = true
    }
}
