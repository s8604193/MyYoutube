//
//  ChannelData.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class PlayList: NSObject {
    
    var playListData: Array<Dictionary<String,AnyObject>> = []
    
    var nextPage: String!
    
    func setupValue(dictionary: Dictionary<String,AnyObject>) {
        
        playListData = []
        
        nextPage = nil
        if let n = dictionary["nextPageToken"]{
            nextPage = n as! String
        }
        
        if let value = dictionary["items"] as? Array<AnyObject>{
            for i in 0  ..< value.count {
                if let items = value[i] as? Dictionary<String, AnyObject>{
                    if let playlistSnippetDict = (items as Dictionary<String, AnyObject>)["snippet"] as? Dictionary<String, AnyObject> {
                        var desiredPlaylistItemDataDict = Dictionary<String, AnyObject>()
                        desiredPlaylistItemDataDict["title"] = playlistSnippetDict["title"]
                        
                        if let im = playlistSnippetDict["thumbnails"]  {
                            if let image = ((im as! Dictionary<String, AnyObject>)["high"] as! Dictionary<String, AnyObject>)["url"] {
                                desiredPlaylistItemDataDict["thumbnail"] =  image
                        }
                        }
                        
                        if let des = playlistSnippetDict["description"] {
                            desiredPlaylistItemDataDict["description"] = des
                        }
                        desiredPlaylistItemDataDict["videoId"] = (playlistSnippetDict["resourceId"] as! Dictionary<String, AnyObject>)["videoId"]
                        playListData.append(desiredPlaylistItemDataDict)
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


