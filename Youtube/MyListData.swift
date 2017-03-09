//
//  MyListData.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class MyListData: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var listData: [Dictionary<String,AnyObject>] = []
    
    var homeController: ViewController?
    
    var collectionView: UICollectionView!
    
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    var viewController: ViewController?
    
    override func setupView() {
        super.setupView()
        
        listData = moc.loadPlayList()! as [Dictionary<String,AnyObject>]
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0.5
        
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        backgroundColor = .white
        
        addSubview(collectionView)
        addSubview(view)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(NewPlayList.self, forCellWithReuseIdentifier: "newplaylist")
        collectionView.register(PlayListCell.self, forCellWithReuseIdentifier: "cellid")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listData.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var key: String!
        
        if indexPath.item == 0 {
            key = "newplaylist"
        } else {
            key = "cellid"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath)
        
        if indexPath.item != 0 {
            (cell as! PlayListCell).playListData = listData[indexPath.item - 1]
            
            (cell as! PlayListCell).setupCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width,height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > 0 {
            self.homeController?.showControllerForSetting(playListName: listData[indexPath.item - 1]["name"] as! String,id: listData[indexPath.item]["id"] as! Int)
        }
    }
    
    
}
