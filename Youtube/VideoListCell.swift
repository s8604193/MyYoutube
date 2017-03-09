//
//  VideoListCell.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/28.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class VideoListCell:PlayListCell {
 
    var playListId: Int!
    
    override func handleDelete() {
        
        if moc.deleteVideo(playListId: playListId, videoId: playListData!["id"] as! String){
            Hint.shared.showOneLineMessage(message: "delete success")
            (controller as! ShowPlayListCelll).reload()
            
        } else{
            Hint.shared.showOneLineMessage(message: "delete fail")
        }
    }

}
