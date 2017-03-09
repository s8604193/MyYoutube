//
//  myPlayListCell.swift
//  Youtube
//
//  Created by Leo on 2017/3/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class myPlayListCell: BaseCell {

    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
        }
    }
    
    var titleData: String!
    
    let title: UILabel = {
        let t = UILabel()
        t.textAlignment = .left
        t.backgroundColor = .clear
        return t
    }()
    
    override func setupView() {
        super.setupView()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.rgb(red: 191, green: 191, blue: 191).cgColor
        
        addSubview(title)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: title)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: title)
    }

    func setup(){
    
        title.text = titleData
    }
}
