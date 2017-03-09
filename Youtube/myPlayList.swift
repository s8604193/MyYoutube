//
//  myPlayList.swift
//  Youtube
//
//  Created by Leo on 2017/3/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class myPlayList:NSObject {
    
    var searchData: Array<Dictionary<String,AnyObject>> = []
    
    var nextPage:String!
    
    func setupValue(dictionary: Dictionary<String,AnyObject>) {
        
        var desiredPlaylistItemDataDict = Dictionary<String, AnyObject>()
        
        searchData = []
        
        nextPage = nil
        if let page = dictionary["nextPageToken"]{
            nextPage = page as? String
        }
        if let value = dictionary["items"] as? Array<AnyObject>{
            for i in 0  ..< value.count {
                if let items = value[i] as? Dictionary<String, AnyObject>{
                    
                    desiredPlaylistItemDataDict["channelId"] = items["id"]
                    
                    if let playlistSnippet = (items as Dictionary<String, AnyObject>)["snippet"] as? Dictionary<String, AnyObject>{
                        
                        desiredPlaylistItemDataDict["title"] = playlistSnippet["title"]
                        
                        searchData.append(desiredPlaylistItemDataDict)
                    }
                    
                    
                    
                }
                
            }
        }
        
    }
    
    init(dictionary: Dictionary<String,AnyObject>) {
        
        super.init()
        
        setupValue(dictionary: dictionary)
        
    }
    
}
