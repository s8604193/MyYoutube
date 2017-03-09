//
//  VideoList.swift
//  Youtube
//
//  Created by Leo on 2017/2/19.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class VideoPlayerView: UIView {
    
    var videoPlayer: YouTubePlayerView!
    
    var isRandom = false
    
    var isPlaying = true
    
    var isMute: Bool = false
    
    var controllerIsHide: Bool = true
    
    var time: Timer!
    
    let blackView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .gray
        bv.alpha = 0.9
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.isHidden = true
        return bv
    }()
    
    let blackViewbottom: UIView = {
        let bv = UIView()
        bv.backgroundColor = .gray
        bv.alpha = 0.9
        bv.isHidden = true
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    let randomButton: UIButton = {
        let lb = UIButton()
        lb.setImage(UIImage(named: "Random"), for: .normal)
        lb.tintColor = .white
        lb.addTarget(self, action: #selector(handleRandom), for: .touchUpInside)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.rgb(red: 191, green: 191, blue: 191)
        lb.isHidden = true
        return lb
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        let image = UIImage(named: "Circle")
        UIGraphicsBeginImageContext(CGSize(width: 20, height: 20))
        image?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        slider.setThumbImage(newImage, for: .normal)
        slider.maximumValueImageRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        slider.addTarget(self, action: #selector(handleSliderTap), for: .touchDown)
        slider.addTarget(self, action: #selector(handleSliderDragg), for: .touchDragInside)
        slider.addTarget(self, action: #selector(handleSliderUp), for: .touchUpInside)
        slider.isHidden = true
        return slider
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(red: 191, green: 191, blue: 191)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePausePlay), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Cancel")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let volumeButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(named: "Speaker"), for: .normal)
        v.addTarget(self, action: #selector(handleVolume), for: .touchUpInside)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    
    func handleVolume(){
        
        if isMute {
            videoPlayer.unMute()
            volumeButton.setImage(UIImage(named: "Speaker"), for: .normal)
        }else {
            videoPlayer.mute()
            volumeButton.setImage(UIImage(named: "Mute"), for: .normal)
        }
        
        isMute = !isMute
    }
    
    func handleRandom(){
        if isRandom {
            
            randomButton.setImage(UIImage(named: "Random"), for: .normal)
        } else {
            
            randomButton.setImage(UIImage(named: "Random_black"), for: .normal)
        }
        
        isRandom = !isRandom
    }
    
    func handleClose(){
        
        videoPlayer.stop()
        
        videoPlayer.clear()
        
        videoPlayer = nil
        
        self.removeFromSuperview()
    }
    
    func handlePausePlay() {
        
        if isPlaying {
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            videoPlayer.pause()
        } else {
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
            videoPlayer.play()
        }
        
        isPlaying = !isPlaying
    }
    
    func handleSliderTap() {
        
        videoPlayer.pause()
        
    }
    
    func handleSliderDragg(){
        
        videoPlayer.seekTo(videoSlider.value * Float(videoPlayer.getDuration()!)!, seekAhead: true)
    }
    
    func handleSliderUp(){
        
        if isPlaying {
            videoPlayer.play()
        }
        
    }
    
    func handleTap(){
        
        if controllerIsHide {
            
            pausePlayButton.isHidden = false
            videoSlider.isHidden = false
            videoLengthLabel.isHidden = false
            currentTimeLabel.isHidden = false
            closeButton.isHidden = false
            blackViewbottom.isHidden = false
            blackView.isHidden = false
            titleLabel.isHidden = false
            randomButton.isHidden = false
            volumeButton.isHidden = false
            
        } else {
            self.pausePlayButton.isHidden = true
            self.videoSlider.isHidden = true
            self.videoLengthLabel.isHidden = true
            self.currentTimeLabel.isHidden = true
            self.closeButton.isHidden = true
            self.blackView.isHidden = true
            self.blackViewbottom.isHidden = true
            self.titleLabel.isHidden = true
            self.randomButton.isHidden = true
            self.volumeButton.isHidden = true
        }
        
        controllerIsHide = !controllerIsHide
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        
        let centerWidth = controlsContainerView.frame.width / 2
        let centerHeight = controlsContainerView.frame.height / 2
        
        controlsContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(handleTap)))
        
        controlsContainerView.backgroundColor = .black
        
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(blackViewbottom)
        controlsContainerView.addSubview(blackView)
        controlsContainerView.addSubview(titleLabel)
        controlsContainerView.addSubview(closeButton)
        controlsContainerView.addSubview(videoSlider)
        controlsContainerView.addSubview(currentTimeLabel)
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(randomButton)
        controlsContainerView.addSubview(pausePlayButton)
        controlsContainerView.addSubview(volumeButton)
        
        blackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        blackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        blackViewbottom.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blackViewbottom.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blackViewbottom.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        blackViewbottom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        controlsContainerView.addConstraintsWithFormat(format: "H:|-8-[v0(20)]-8-[v1]-8-|", views: closeButton,titleLabel)
        controlsContainerView.addConstraintsWithFormat(format: "H:|-\(centerWidth - 20)-[v0(40)]-\(centerWidth - 100)-[v1(40)]-40-|", views: pausePlayButton,randomButton)
        controlsContainerView.addConstraintsWithFormat(format: "H:|[v0(40)][v1][v2(40)][v3(40)]|", views: currentTimeLabel,videoSlider,videoLengthLabel,volumeButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:|-8-[v0(20)]-\(centerHeight * 2 - 68)-[v1(40)]|", views: closeButton,currentTimeLabel)
        controlsContainerView.addConstraintsWithFormat(format: "V:|-8-[v0(20)]-\(centerHeight - 48)-[v1(40)]-\(centerHeight - 60)-[v2(40)]|", views: titleLabel,pausePlayButton,videoSlider)
        controlsContainerView.addConstraintsWithFormat(format: "V:|-8-[v0(20)]-\(centerHeight - 48)-[v1(40)]-\(centerHeight - 60)-[v2(40)]|", views: titleLabel,randomButton,videoLengthLabel)
        controlsContainerView.addConstraintsWithFormat(format: "V:|-8-[v0(20)]-\(centerHeight * 2 - 68)-[v1(40)]|", views: titleLabel,volumeButton)

        time = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.handleTime), userInfo: nil, repeats: true)
    }
    
    func handleTime(){
        
        if videoPlayer != nil {
            if let time = Float(videoPlayer.getCurrentTime()!),let videoLength = Float(videoPlayer.getDuration()!) {
            
                if time != videoLength {
                
                    let minute = String(format: "%02d",Int(time) / 60)
                
                    let second = String(format: "%02d",Int(time) % 60)
                
                    currentTimeLabel.text = "\(minute):\(second)"
                
                    let min = String(format: "%02d",Int(videoLength) / 60)
                
                    let sec = String(format: "%02d",Int(videoLength) % 60)
                
                    videoLengthLabel.text = "\(min):\(sec)"
                }
            
                if isPlaying {
                
                    videoSlider.value = (Float(time) / Float(videoLength))
                }
            
            }
        } else {
        
        time.invalidate()
        time = nil
        }
    }
    
    func loadVideo(videoId: String,title: String){
        
        titleLabel.text = title
        
        if let vp = videoPlayer {
            vp.loadVideoID(videoId)
            self.controlsContainerView.backgroundColor = .clear
        }
        
        
    }
    
    func setupPlayerView() {
        
        videoPlayer = YouTubePlayerView(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height))
        
        self.addSubview(videoPlayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
