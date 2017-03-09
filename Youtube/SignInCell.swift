//
//  SignInCell.swift
//  Youtube
//
//  Created by Leo on 2017/3/1.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class SignInCell: BaseCell {

    let label: UILabel = {
        let la = UILabel()
        la.textAlignment = .center
        la.text = "GoogleAccount"
        return la
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = .white
        
        addSubview(label)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: label)
        addConstraintsWithFormat(format: "H:|[v0]|", views: label)
    }

}
