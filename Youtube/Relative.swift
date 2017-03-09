//
//  ChannelData.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class Relative: NSObject {
    
    var channelListData: Array<Dictionary<String,AnyObject>> = []
    
    func setupValue(dictionary: Dictionary<String,AnyObject>) {
        
        channelListData = []
        
        if let value = dictionary["items"] as? Array<AnyObject>{
            for i in 0  ..< value.count {
                if let items = value[i] as? Dictionary<String, AnyObject>{
                    var desiredPlaylistItemDataDict = Dictionary<String, AnyObject>()
                    desiredPlaylistItemDataDict["videoId"] = ((items as? Dictionary<String,AnyObject>)?["id"] as? Dictionary<String,AnyObject>)?["videoId"]
                    
                    if let playlistSnippetDict = (items as Dictionary<String, AnyObject>)["snippet"] as? Dictionary<String, AnyObject> {
                        desiredPlaylistItemDataDict["title"] = playlistSnippetDict["title"]
                        desiredPlaylistItemDataDict["thumbnail"] = ((playlistSnippetDict["thumbnails"] as! Dictionary<String, AnyObject>)["high"] as! Dictionary<String, AnyObject>)["url"]
                        desiredPlaylistItemDataDict["description"] = playlistSnippetDict["description"]
                    }
                    channelListData.append(desiredPlaylistItemDataDict)
                }
                
            }
        }
        
    }
    
    init(dictionary: Dictionary<String,AnyObject>) {
        
        super.init()
        
        setupValue(dictionary: dictionary)
        
    }
    
}


