//
//  ListCollectionView.swift
//  Youtube
//
//  Created by Leo on 2017/2/19.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class VideoCollectionView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var videoPlayer: VideoPlayerView!
    
    var videoData: Dictionary<String,AnyObject>!
    
    var relativeVideo: Array<Dictionary<String,AnyObject>>!
    
    var height: Int!
    
    var moreImformation: Bool = false
    
    let playlistBar: AddVideoToPlayList = {
        let pb = AddVideoToPlayList()
        return pb
    }()
    
    let collectionView: UICollectionView = {
        if let keyWindow = UIApplication.shared.keyWindow {
            let width = keyWindow.frame.width
            let height = width / 16 * 9
            let frame = CGRect(x: 8, y: height + 120, width: (width - 16), height: (keyWindow.frame.height - height - 120))
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: (width - 16), height: 50)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            let l  = UICollectionView(frame: frame, collectionViewLayout: layout)
            l.backgroundColor = .white
            return l
        }
        return UICollectionView()
    }()
    
    let blackView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .black
        bv.alpha = 0.8
        bv.isHidden = true
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    let descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.backgroundColor = .white
        dl.textAlignment = .left
        dl.numberOfLines = 0
        dl.font = UIFont.systemFont(ofSize: 10)
        dl.changeLineSpace(space: 0)
        return dl
    }()
    
    let addButton: ClickButton = {
        let ab = ClickButton()
        let image = UIImage(named: "Add")
        ab.setImage(image, for: .normal)
        ab.translatesAutoresizingMaskIntoConstraints = false
        ab.layer.borderColor = UIColor.black.cgColor
        ab.addTarget(self, action: #selector(handleAddNewVideo), for: .touchUpInside)
        return ab
    }()
    
    let showDetailButton: UIButton = {
        let sb = UIButton()
        sb.backgroundColor = .white
        sb.setTitleColor(.blue, for: .normal)
        sb.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return sb
    }()
    
    func handleAddNewVideo() {
        
        blackView.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let keyWindow = UIApplication.shared.keyWindow {
                
                self.playlistBar.frame = CGRect(x: 0,y: keyWindow.frame.height - CGFloat(self.height!),width: keyWindow.frame.width ,height: CGFloat(self.height!))
            }
        }, completion: { (completionAnimation) in
            
        })
    }
    
    func handleHideButton() {
        
        blackView.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let keyWindow = UIApplication.shared.keyWindow {
                
                self.playlistBar.frame = CGRect(x: 0,y: keyWindow.frame.height,width: keyWindow.frame.width ,height: CGFloat(self.height))
            }
            
        }, completion: { (completionAnimation) in
            
        })
    
    }
    
    init(frame: CGRect,dictionary: Dictionary<String,AnyObject>) {
        
        super.init(frame: frame)
        
        self.relativeVideo = []
        
        self.videoData = dictionary
        
        self.playlistBar.dictionary = dictionary
        
        descriptionLabel.text = dictionary["description"] as? String
        
        let videoPlayerFrame = CGRect(x: 0,y: 0,width: frame.width ,height: frame.width / 16 * 9)
        videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
        
        addSubview(collectionView)
        addSubview(descriptionLabel)
        addSubview(showDetailButton)
        addSubview(videoPlayer)
        addSubview(addButton)
        addSubview(blackView)
        addSubview(playlistBar)
        
        showDetailButton.addTarget(self, action: #selector(handleShow), for: .touchUpInside)
        
        playlistBar.controller = self
        
        blackView.frame = frame
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHideButton)))
        
        if playlistBar.listData.count > 5 {
            height = 300
        } else {
            height = (playlistBar.listData.count + 1) * 50
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let heigh = frame.width / 16 * 9
        
        showDetailButton.titleRect(forContentRect: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        
        collectionView.register(RelatvieVideoListCell.self, forCellWithReuseIdentifier: "cellId")
        
        showDetailButton.setTitle("show more imformation", for: .normal)
            
        descriptionLabel.frame = CGRect(x: 8, y: heigh + 50, width: frame.width - 16, height: 50)
        showDetailButton.frame = CGRect(x: 8, y: heigh + 100, width: frame.width - 16, height: 10)
        
        playlistBar.frame = CGRect(x: 0,y: frame.height,width: frame.width,height: CGFloat(height))
        
        addConstraint(NSLayoutConstraint(item: addButton,attribute: .top,relatedBy: .equal, toItem: self.videoPlayer, attribute: .bottom, multiplier: 1, constant: 5))
        
        addConstraint(NSLayoutConstraint(item: addButton,attribute: .left,relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: addButton,attribute: .right,relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -8))
        
        addConstraint(NSLayoutConstraint(item: addButton,attribute: .height,relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))

        willRemoveSubview(videoPlayer)
        
        
        if let videoId = videoData["videoId"] , let title = videoData["title"] {
        
            videoPlayer.loadVideo(videoId: videoId as! String, title: title as! String)
            
            YoutubeApi.sharedInstance.relativeVideo(videoId: videoId as! String)
            
            relativeVideo = YoutubeApi.sharedInstance.searchData
            
            YoutubeApi.sharedInstance.searchData = nil
            
        }
    }
    
    func handleShow(){
    
        if moreImformation {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let heigh = self.frame.width / 16 * 9
                
                self.descriptionLabel.frame = CGRect(x: 8, y: heigh + 50, width: self.frame.width - 16, height: 50)
                self.showDetailButton.frame = CGRect(x: 8, y: heigh + 100, width: self.frame.width - 16, height: 20)
                self.showDetailButton.setTitle("show more imformation", for: .normal)
                
            })
        }else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let h = self.frame.height
                let heigh = self.frame.width / 16 * 9
                
                self.descriptionLabel.frame = CGRect(x: 8, y: heigh + 50, width: self.frame.width - 16, height: h - (20 + heigh + 50))
                self.showDetailButton.frame = CGRect(x: 8, y: h - 20, width: self.frame.width - 16, height: 20)
                self.showDetailButton.setTitle("show less imformation", for: .normal)
                
            })
        }
        moreImformation = !moreImformation
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.removeFromSuperview()
            
        }, completion: { (completionAnimation) in
            
            UIApplication.shared.setStatusBarHidden(false, with: .slide)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! RelatvieVideoListCell
        
        cell.videoData = self.relativeVideo[indexPath.item]
        
        cell.setup()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return relativeVideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.videoData = relativeVideo[indexPath.item]
        
        self.relativeVideo = []
        
        if let videoId = videoData["videoId"] , let title = videoData["title"] {
            
            videoPlayer.loadVideo(videoId: videoId as! String, title: title as! String)
            
            YoutubeApi.sharedInstance.relativeVideo(videoId: videoId as! String)
            
            relativeVideo = YoutubeApi.sharedInstance.searchData
            
        }

        descriptionLabel.text = relativeVideo[indexPath.item]["description"] as? String
        
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
