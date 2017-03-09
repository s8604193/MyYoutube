//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Leo on 2017/2/13.
//  Copyright © 2017年 Leo. All rights reserved.
//


import UIKit



class Launcher: NSObject {
    
    var view: closeByDetected?
    
    var channelList: Array<Dictionary<String,AnyObject>>!
    
    var videoData: Dictionary<String,AnyObject>!
    
    func listLauncher(list: Array<Dictionary<String,AnyObject>>,playingId: Int){
        
        channelList = list
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            view = closeByDetected(frame: keyWindow.frame)
            view?.backgroundColor = UIColor.white
            
            view?.frame = CGRect(x: keyWindow.frame.width - 10 ,y: keyWindow.frame.height - 10,width: 10, height: 10)
            
            let viewController = ListCollectionView(frame: CGRect(x: 0,y: 0,width: keyWindow.frame.width, height: keyWindow.frame.height), channelList: list, playingId: playingId)
            
            view?.addSubview(viewController)
            view?.willRemoveSubview(viewController)
            
            keyWindow.addSubview(view!)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view?.frame = keyWindow.frame
            }, completion: { (completionAnimation) in
                
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
    
    func videoLauncher(dictionary: Dictionary<String,AnyObject>){
        
        videoData = dictionary
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            view = closeByDetected(frame: keyWindow.frame)
            view?.backgroundColor = UIColor.white
            
            view?.frame = CGRect(x: keyWindow.frame.width - 10 ,y: keyWindow.frame.height - 10,width: 10, height: 10)
            
            let viewController = VideoCollectionView(frame: CGRect(x: 0,y: 0,width: keyWindow.frame.width, height: keyWindow.frame.height),dictionary: videoData)
            
            view?.addSubview(viewController)
            view?.willRemoveSubview(viewController)
            
            keyWindow.addSubview(view!)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view?.frame = keyWindow.frame
            }, completion: { (completionAnimation) in
                
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
    

}


class closeByDetected: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.removeFromSuperview()
            
        }, completion: { (completionAnimation) in
            
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
