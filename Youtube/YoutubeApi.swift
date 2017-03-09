//
//  ApiService.swift
//  Youtube
//
//  Created by Leo on 2017/2/9.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class YoutubeApi: NSObject {
    
    static let sharedInstance = YoutubeApi()
    
    let apiKey = "AIzaSyBvF-2lGqTv3YwXOUG79CCyZNx2pcl4Elw"
    
    let session = URLSession.shared
    
    var jsonData: Dictionary<String,AnyObject>?
    
    var wait: Bool?
    
    var searchData: Array<Dictionary<String,AnyObject>>?
    
    var nextPage:String? = nil
    
    var prevPage:String? = nil
    
    func getMyPlayList(string: String){
        
        let url = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&mine=true&access_token=\(string)"
        print(url)
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
        
        let fun = myPlayList(dictionary: jsonData!)
        
        searchData = fun.searchData
        
        nextPage = nil
        
        nextPage = fun.nextPage
        
        while nextPage != nil {
        
            let surl = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&mine=true&pageToken=\(nextPage!)&access_token=\(string)"
            
            wait = true
            
            initialiseTaskForGettingData(urlString: surl)
            
            while wait! {}
            
            let fun = myPlayList(dictionary: jsonData!)
            
            for i in 0  ..< fun.searchData.count {
                searchData?.append(fun.searchData[i])
            }
            
            nextPage = nil
            
            nextPage = fun.nextPage
        }
        
    }
    
    func relativeVideo(videoId: String){
    
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=\(videoId)&type=video&key=\(apiKey)"
        
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
    
        searchData = Relative(dictionary: jsonData!).channelListData
    }
    
    func searchPageToken(searchString: String,page: String){
        
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&order=viewCount&pageToken=\(page)&q=\(searchString)&type=video&key=\(apiKey)"
        
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
        
        let li = SearchData(dictionary: jsonData!)
        
        searchData = li.searchData
        
        if li.nextPage != nil {
            nextPage = li.nextPage
        }
        
        if li.prevPage != nil {
            prevPage = li.prevPage
        }
        
    }
    func search(searchString: String){
        
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&order=viewCount&q=\(searchString)&type=video&key=\(apiKey)"
        
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
        
        let li = SearchData(dictionary: jsonData!)
        
        searchData = li.searchData
        
        if li.nextPage != nil {
            nextPage = li.nextPage
        }
        
        if li.prevPage != nil {
            prevPage = li.prevPage
        }
    }
    
    func playList(string: String){
        
        let url = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails,snippet&playlistId=\(string)&maxResults=50&key=\(apiKey)"
        
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
        
        let l = PlayList(dictionary: jsonData!)
        
        searchData = l.playListData
        
        nextPage = l.nextPage
        
        while nextPage != nil {
        
            let url = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails,snippet&pageToken=\(nextPage)&playlistId=\(string)&maxResults=50&key=\(apiKey)"
            
            wait = true
            
            initialiseTaskForGettingData(urlString: url)
            
            while wait! {}
            
            let l = PlayList(dictionary: jsonData!)
            
            for i in 0 ..< l.playListData.count {
                searchData?.append(l.playListData[i])
            }
            
            nextPage = l.nextPage
        
        }
        
    }
    
    func setHomeList(){
        
        let url = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails,snippet&playlistId=PLFgquLnL59alOwE-wZfEygqgABT2yRD9V&maxResults=50&key=\(apiKey)"
        
        wait = true
        
        initialiseTaskForGettingData(urlString: url)
        
        while wait! {}
        
        searchData = PlayList(dictionary: jsonData!).playListData
        
    }
    
    func initialiseTaskForGettingData(urlString: String){
        
        let request = URLRequest(url: URL(string: urlString)!)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, HTTPStatusCode, error) in
            if error != nil {
                print(error as Any)
                return
            }
            else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<String,AnyObject>{
                        
                        self.jsonData = json
                        
                        self.wait = false
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
        })
        task.resume()
        
    }
}
