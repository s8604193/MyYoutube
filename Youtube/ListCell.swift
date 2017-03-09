//
//  ListCell.swift
//  Youtube
//
//  Created by Leo on 2017/2/19.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class ListCell: BaseCell{
    
    var video: Dictionary<String,AnyObject>!
    
    let thumbnailImageView: CustomerImageView = {
        let imageView = CustomerImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    func setupThumbnailImage(){
        
        if let thumbnailImageUrl = video["thumbnail"]{
            
            thumbnailImageView.loadImageUsinUrlString(string: thumbnailImageUrl as! String)
            
        }
        
    }
    override func setupView(){
        
        super.setupView()
    }
    
    func setupTitleLabel(){
        
        titleLabel.text = video["name"] as! String
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-5-[v0(40)]-[v1]|", views: thumbnailImageView,titleLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0(40)]-5-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-5-[v0(40)]-5-|", views: titleLabel)
    }
    
    func setupAll(){
        
        setupThumbnailImage()
        
        setupTitleLabel()
        
    }
}
