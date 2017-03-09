//
//  VidoeCell.swift
//  youtube
//
//  Created by Leo on 2017/2/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class VideoCell: BaseCell{
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            if let thumbImage  = (video?.thumbnail_image_name){
                thumbnailImageView.image = UIImage(named: thumbImage)
            }
            
        }
        
        
    }
    
    let thumbnailImageView: CustomerImageView = {
        let imageView = CustomerImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230,green: 230,blue: 230)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    func setupThumbnailImage(){
        
        if let thumbnailImageUrl = video?.thumbnail_image_name{
            
            thumbnailImageView.loadImageUsinUrlString(string: thumbnailImageUrl)
            
        }
        
    }
    
    override func setupView(){
        super.setupView()
        addSubview(thumbnailImageView)
        addSubview(sepratorView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-22-[v0]-36-[v1(1)]|", views: thumbnailImageView,  sepratorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: sepratorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel,attribute: .top,relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel,attribute: .left,relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: titleLabel,attribute: .right,relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -20))
        
        addConstraint(NSLayoutConstraint(item: titleLabel,attribute: .height,relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 15))
    }
}
