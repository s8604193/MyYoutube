//
//  FeedCell.swift
//  Youtube
//
//  Created by Leo on 2017/2/10.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class SearchCell: FeedCell {
    
    var searchString: String!
    
    var searchData: Array<Dictionary<String,AnyObject>> = []
    
    var videoArray: Array<Video> = []
    
    var videoAmountOfPage:Int!
    
    let nextButton: UIButton = {
        let nb = UIButton()
        nb.setImage(UIImage(named:"Right_arrow"), for: .normal)
        return nb
    }()
    
    func handleNextPage(){
        
        YoutubeApi.sharedInstance.searchPageToken(searchString: searchString, page: YoutubeApi.sharedInstance.nextPage!)
        
        fetchVideos()
        
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
    }
    
    let prevButton: UIButton = {
        let nb = UIButton()
        nb.setImage(UIImage(named:"Left_arrow"), for: .normal)
        return nb
    }()
    
    func handlePrevPage(){
        
        YoutubeApi.sharedInstance.searchPageToken(searchString: searchString, page: YoutubeApi.sharedInstance.prevPage!)
        
        fetchVideos()
        
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
    }
    
    override func setupView() {
        
        fetchVideos()
        setupCell()
        
        addSubview(collectionView)
        addSubview(nextButton)
        addSubview(prevButton)
        
        backgroundColor = .white
        
        self.collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        
        let height = frame.height - 20
        let width = frame.width / 2
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]-20-|", views: collectionView)
        
        nextButton.frame = CGRect(x: Int(width), y: Int(height), width: Int(width), height: 20)
        prevButton.frame = CGRect(x: 0, y: Int(height), width: Int(width), height: 20)
        
        nextButton.isHidden = true
        prevButton.isHidden = true
        
        nextButton.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(handlePrevPage), for: .touchUpInside)
    }
    
    override func setupCell() {
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    override func fetchVideos() {
        
        nextButton.isHidden = true
        prevButton.isHidden = true
        
        videoAmountOfPage = 0
        
        if YoutubeApi.sharedInstance.searchData != nil {
            
            self.videoArray = []
            
            self.searchData = YoutubeApi.sharedInstance.searchData!
        
            YoutubeApi.sharedInstance.searchData = nil
        
            turnDictionaryToVideo()
            
            self.collectionView.reloadData()
        
        }
        
        
    }
    
    func turnDictionaryToVideo() {
        
        var maxAmount = videoAmountOfPage + 5
        
        if searchData.count < maxAmount {
            maxAmount = searchData.count
        }
        if videoAmountOfPage < maxAmount {
            
            for i in videoAmountOfPage  ..< maxAmount {
            
                let video = Video(dictionary: ["0":"0" as AnyObject])
            
                video.thumbnail_image_name = searchData[i]["thumbnail"] as? String
            
                video.title = searchData[i]["title"] as? String
            
                video.descrip = searchData[i]["description"] as? String
            
                video.videoId = searchData[i]["videoId"] as? String
            
                self.videoArray.append(video)
            
            }
        
            self.videos = videoArray
        
            videoAmountOfPage  = videoAmountOfPage + 5
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            
            if videoAmountOfPage < searchData.count {
                turnDictionaryToVideo()
                self.collectionView.reloadData()
            } else {
                
                if YoutubeApi.sharedInstance.nextPage != nil {
                    nextButton.isHidden = false
                }
                if YoutubeApi.sharedInstance.prevPage != nil {
                    prevButton.isHidden = false
                }
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("launcher")
        let launcher = Launcher()
        launcher.videoLauncher(dictionary: (searchData[indexPath.item]))
        
    }
}
