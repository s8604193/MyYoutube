//
//  ListCollectionView.swift
//  Youtube
//
//  Created by Leo on 2017/2/19.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class ListCollectionView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var videoPlayer: VideoPlayerView!
    
    var playingVideo = -1
    
    var channelList: Array<Dictionary<String,AnyObject>>!
    
    var timer: Timer!
    
    var collectionView: UICollectionView!
    
    init(frame: CGRect,channelList: Array<Dictionary<String,AnyObject>>, playingId: Int) {
        
        super.init(frame: frame)
        
        self.channelList = channelList
        
        let height = (frame.width * 9 / 16)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsetsMake(height, 1, 1, 1)
        layout.itemSize = CGSize(width: frame.width - 10 ,height: 50)
        
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: frame.width,height: frame.height),collectionViewLayout: layout)
        
        addSubview(collectionView)
    
        let videoPlayerFrame = CGRect(x: 0,y: 0,width: frame.width ,height: height)
        videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
        
        addSubview(videoPlayer)
        
        willRemoveSubview(videoPlayer)
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.rgb(red: 204, green: 255, blue: 255)
    
        playingVideo = playingId
            
        collectionView.reloadData()
        
        videoPlayer.loadVideo(videoId: channelList[playingId]["id"] as! String,title: channelList[playingId]["name"] as! String)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ListCell
        if indexPath.item == playingVideo {
            cell.backgroundColor = UIColor.rgb(red: 128, green: 212, blue: 255)
        } else {
            cell.backgroundColor = .white
        }
        cell.video = channelList[indexPath.item]
        cell.setupAll()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        playingVideo = indexPath.item
        
        collectionView.reloadData()
        
        videoPlayer.loadVideo(videoId: channelList[indexPath.item]["id"] as! String,title: channelList[indexPath.item]["name"] as! String)
        
        if channelList.count > 1 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleVideoTime), userInfo: nil, repeats: true)
        }
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.removeFromSuperview()
            
        }, completion: { (completionAnimation) in
            
            UIApplication.shared.setStatusBarHidden(false, with: .slide)
        })
    }
    
    func handleVideoTime(){
        
        if self.videoPlayer.videoPlayer != nil {
            if let time = Float(videoPlayer.videoPlayer.getCurrentTime()!),let videoLength = Float  (videoPlayer.videoPlayer.getDuration()!){
            
                if time == videoLength {
                
                    if videoPlayer.isRandom {
                        var random: Int!
                    
                        repeat {
                            random = Int(arc4random_uniform(UInt32(channelList.count)))
                        } while random == playingVideo
                    
                        playingVideo = random
                    
                    } else {
                    
                        playingVideo = (playingVideo + 1) % channelList.count
                    
                    }
                
                    collectionView.reloadData()
                
                    videoPlayer.loadVideo(videoId: channelList[playingVideo]["id"] as! String,title: channelList[playingVideo]["name"] as! String)
                
                }
            
            }
        } else {
            if let tim = timer {
                timer.invalidate()
                timer = nil
            }
            
        
        }
        
    }
}
