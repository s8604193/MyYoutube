//
//  Video.swift
//  Youtube
//
//  Created by Leo on 2017/2/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    var descrip: String?
    var videoId: String?
    var array = ["thumbnail_image_name","title","number_of_views","uploadDate","duration"]
    
    override func setValue(_ value: Any?, forKey key: String){
        if key != "channel" {
            super.setValue(value, forKey: key)
        }
        
    }
    
    init(dictionary: [String:AnyObject]) {
        
        super.init()
        
        for (key,_) in dictionary {
            if let number = array.index(of: key) {
                if number >= 0 {
                    setValuesForKeys(dictionary)
                }
            }
        }
    }
    
    
}



