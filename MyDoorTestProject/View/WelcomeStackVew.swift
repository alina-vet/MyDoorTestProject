//
//  WelcomeStackVew.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 12.07.2022.
//

import UIKit

class WelcomeStackVew: UIStackView {

    private var imageHome: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Home")
        imageView.contentMode = .right
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont(name: Constants.fontBold, size: 35)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(34)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(superview!.frame.size.height / 4.5)
        }
    }
    
    private func configure() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 18

        addArrangedSubview(welcomeLabel)
        addArrangedSubview(imageHome)
    }

}
