//
//  Hint.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/27.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class Hint: NSObject{

    static let shared = Hint()
    
    let view: UILabel = {
        let v = UILabel()
        v.backgroundColor = .white
        v.font = UIFont.systemFont(ofSize: 15)
        v.textAlignment = .center
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    func showOneLineMessage(message: String){
    
        if let keyWindow = UIApplication.shared.keyWindow {
            
            view.text = message
            
            keyWindow.addSubview(view)
            
            let length = message.characters.count * 16
            let height = keyWindow.frame.height
            let width = keyWindow.frame.width
            
            if (Int(width / 2) > (length / 2)) {
                view.frame = CGRect(x: Int(width / 2) - (length / 2), y: Int(height / 2) - 12, width: length , height: 25)
            }else {
                view.frame = CGRect(x: 0 , y: Int(height / 2) - 12, width: Int(width) , height: 25)
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            
                self.view.removeFromSuperview()
            })
        }
    }

}
