//
//  AddVideoToPlayList.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class AddVideoToPlayList: AccountCell {

    var controller:  VideoCollectionView?
    
    var dictionary =  Dictionary<String,AnyObject>()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            if moc.insert(myEntityName: "CoreDataVideo", attributeInfo: ["videoid":dictionary["videoId"],"playlistid":listData[indexPath.item - 1]["id"],"name":dictionary["title"]]) {
                
                Hint.shared.showOneLineMessage(message: "add video success")
                
                self.controller?.handleHideButton()
            }
        }
        
    }

}
