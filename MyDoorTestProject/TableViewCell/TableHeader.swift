//
//  TableHeader.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 07.07.2022.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {
    
    static let id = "TableHeader"
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "My doors"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.sizeToFit()
        title.frame = CGRect(x: 25, y: contentView.frame.size.height - 30 - title.frame.size.height, width: contentView.frame.size.width, height: title.frame.size.height)
    }
}
