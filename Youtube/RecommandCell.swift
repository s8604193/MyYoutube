//
//  TestCell.swift
//  Youtube
//
//  Created by Leo on 2017/2/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class RecommandCell: FeedCell {
    
    var channelData: Dictionary<String,AnyObject>?
    
    var videoAmountOfPage:Int!
    
    var channelList: Array<Dictionary<String,AnyObject>>?
    
    var videoArray: Array<Video> = []
    
    override func setupCell() {
        collectionView.register(FeedListCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedListCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    override func fetchVideos() {
        
        videoAmountOfPage = 0
        
        YoutubeApi.sharedInstance.setHomeList()
        
        self.channelList = YoutubeApi.sharedInstance.searchData
        
        YoutubeApi.sharedInstance.searchData = nil
        
        turnDictionaryToVideo()
        
        self.videos = videoArray
        
        self.collectionView.reloadData()
        
    }
    
    func turnDictionaryToVideo() {
        
        var maxAmount = videoAmountOfPage + 5
        
        if channelList!.count < maxAmount {
            maxAmount = channelList!.count
        }
        if videoAmountOfPage < maxAmount {
            
            for i in videoAmountOfPage  ..< maxAmount {
            
                let video = Video(dictionary: ["0":"0" as AnyObject])
            
                video.thumbnail_image_name = channelList?[i]["thumbnail"] as? String
            
                video.title = channelList?[i]["title"] as? String
            
                video.descrip = channelList?[i]["description"] as? String
            
                video.videoId = channelList?[i]["videoId"] as? String
            
                self.videoArray.append(video)
            
            }
            
            self.videos = videoArray
            
            videoAmountOfPage  = videoAmountOfPage + 5
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            
            if videoAmountOfPage < channelList!.count {
                turnDictionaryToVideo()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let launcher = Launcher()
        launcher.videoLauncher(dictionary: (channelList?[indexPath.item])!)
        
    }
}

class FeedListCell: VideoCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "recent popular"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func setupView() {
        super.setupView()
        
        addSubview(title)
        
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor,constant: 8).isActive = true
        title.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }

}
