//
//  RelatvieVideoListCell.swift
//  Youtube
//
//  Created by Leo on 2017/3/2.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class RelatvieVideoListCell: BaseCell {

    var videoData: Dictionary<String,AnyObject>!
    
    override var isHighlighted: Bool {
        didSet{
            label.backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white        
        }
    }
    
    let thumbnailImageView: CustomerImageView = {
        let imageView = CustomerImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = .white
        
        addSubview(thumbnailImageView)
        addSubview(label)
        
        addConstraintsWithFormat(format: "H:|[v0(80)]-5-[v1]|", views: thumbnailImageView,label)
        addConstraintsWithFormat(format: "V:|-2-[v0]-3-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-3-|", views: label)
    }
    
    func setup(){
    
        if let imageUrl = videoData["thumbnail"] {
            thumbnailImageView.loadImageUsinUrlString(string: imageUrl as! String)
        }
        if let text = videoData["title"] {
            label.text = text as! String
        }
        
        
    }
}
