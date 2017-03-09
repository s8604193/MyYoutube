//
//  SettingCell.swift
//  Youtube
//
//  Created by Leo on 2017/2/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLable.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
        
    }
    
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textAlignment = .left
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupView() {
        
        super.setupView()
        
        addSubview(nameLable)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(15)]-15-[v1]|", views: iconImageView,nameLable)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLable)
        addConstraintsWithFormat(format: "V:[v0(15)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal,toItem: self, attribute: .centerY, multiplier: 1,constant: 0))
        
    }
    
    
}
