//
//  ChannelData.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class SearchData: NSObject {
    
    var searchData: Array<Dictionary<String,AnyObject>> = []
    
    var nextPage:String!
    
    var prevPage:String!
    
    func setupValue(dictionary: Dictionary<String,AnyObject>) {
        
        var desiredPlaylistItemDataDict = Dictionary<String, AnyObject>()
        
        searchData = []
        
        nextPage = nil
        if let page = dictionary["nextPageToken"]{
            nextPage = page as? String
        }
        prevPage = nil
        if let page = dictionary["prevPageToken"]{
            prevPage = page as? String
        }
        
        if let value = dictionary["items"] as? Array<AnyObject>{
            for i in 0  ..< value.count {
                if let items = value[i] as? Dictionary<String, AnyObject>{
                    
                    if let playlistSnippet = (items as Dictionary<String, AnyObject>)["snippet"] as? Dictionary<String, AnyObject> , let playlistId = (items as Dictionary<String, AnyObject>)["id"] as? Dictionary<String, AnyObject>{
                        
                        desiredPlaylistItemDataDict["title"] = playlistSnippet["title"]
                        
                        desiredPlaylistItemDataDict["thumbnail"] = ((playlistSnippet["thumbnails"] as! Dictionary<String, AnyObject>)["high"] as! Dictionary<String, AnyObject>)["url"]
                        
                        desiredPlaylistItemDataDict["description"] = playlistSnippet["description"]
                        
                        desiredPlaylistItemDataDict["videoId"] = playlistId["videoId"]
                        
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
