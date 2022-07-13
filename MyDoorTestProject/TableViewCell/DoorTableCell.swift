//
//  DoorTableCell.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 07.07.2022.
//

import UIKit
import SnapKit

class DoorTableCell: UITableViewCell {
    
    static let id = "DoorTableCell"
    var delegate: DoorCellDelegate?
    
    private var displayStatus: DoorStatus?
    
    private var leftLoadImage = LeftLoadingImageView(frame: .zero)
    private var rightLoadView = RightLoadingImageView()
    
    private var leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Front door"
        label.font = UIFont(name: Constants.fontBold, size: 16)
        label.textColor = UIColor(red: 0.196, green: 0.216, blue: 0.333, alpha: 1)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont(name: Constants.fontRegular, size: 14)
        label.textColor = UIColor(named: "locationTextColor")
        return label
    }()
    
    private let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle(DoorStatus.locked.rawValue, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontBold, size: 15)
        button.addTarget(self, action: #selector(changeStatusAction), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.89, green: 0.918, blue: 0.918, alpha: 1).cgColor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15

        contentView.addSubview(leftImage)
        contentView.addSubview(rightImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(statusButton)
        contentView.addSubview(leftLoadImage)
        contentView.addSubview(rightLoadView)
    }
    
    func configureCell(title: String, location: String) {
        titleLabel.text = title
        locationLabel.text = location
        displayStatus = .locked
        updateDisplayStatus()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 15, right: 10))
        
        leftImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(18)
        }
    
        rightImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(22)
            make.left.equalTo(leftImage).offset(55)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(leftImage).offset(55)
        }
        
        statusButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-14)
            make.centerX.equalTo(contentView)
        }
        
        rightLoadView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-32)
            make.size.equalTo(22)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftImage.image = nil
        rightImage.image = nil
        titleLabel.text = nil
        locationLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func changeStatusAction() {
        displayStatus = .unlocking
        updateDisplayStatus()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.displayStatus = .unlocked
            self.updateDisplayStatus()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.displayStatus = .locked
                self.updateDisplayStatus()
            }
        }
        delegate?.cellTapped(cell: self)
    }
    
    func updateDisplayStatus() {
        switch displayStatus {
        case .locked:
            leftLoadImage.stopAnimate()
            leftImage.image  = Constants.shieldLockedImage!
            rightLoadView.stopAnimate()
            rightImage.image = Constants.doorLockedImage!
            statusButton.setTitle(DoorStatus.locked.rawValue, for: .normal)
            statusButton.setTitleColor(UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 1), for: .normal)
        case .unlocked:
            leftLoadImage.stopAnimate()
            leftImage.image = Constants.shieldUnlockedImage!
            rightLoadView.stopAnimate()
            rightImage.isHidden = false
            rightImage.image = Constants.doorUnlockedImage!
            statusButton.setTitle(DoorStatus.unlocked.rawValue, for: .normal)
            statusButton.setTitleColor(UIColor(red: 0, green: 0.267, blue: 0.545, alpha: 0.5), for: .normal)
        case .unlocking:
            leftLoadImage.animate()
            rightImage.isHidden = true
            rightLoadView.animate()
            statusButton.setTitle(DoorStatus.unlocking.rawValue, for: .normal)
            statusButton.setTitleColor(.black.withAlphaComponent(0.17), for: .normal)
        case .none:
            break
        }
    }
}
