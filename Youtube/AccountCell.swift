//
//  AccountCellId.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit


class AccountCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var listData: [Dictionary<String,AnyObject>] = []
    
    var homeController: ViewController?
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        let co = UICollectionView(frame: .zero, collectionViewLayout: layout)
        co.backgroundColor = .white
        return co
    }()
    
    var viewController: ViewController?
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = .white
        
        listData = moc.loadPlayList()! as [Dictionary<String,AnyObject>]
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(NewPlayList.self, forCellWithReuseIdentifier: "newplaylist")
        collectionView.register(PlayListCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.register(SignInCell.self, forCellWithReuseIdentifier: "signin")
    }
    
    func reload(){
        listData = moc.loadPlayList()! as [Dictionary<String,AnyObject>]
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listData.count + 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var key: String!
        
        if indexPath.item == listData.count + 1{
            key = "signin"
        }else if indexPath.item == 0 {
            key = "newplaylist"
        } else {
            key = "cellid"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: key, for: indexPath)
        
        if indexPath.item == listData.count + 1{
        
            
        }else if indexPath.item != 0 {
            
            (cell as! PlayListCell).controller = self
            
            (cell as! PlayListCell).playListData = listData[indexPath.item - 1]
            
            (cell as! PlayListCell).setupCell()
        }else {
        
            (cell as! NewPlayList).controller = self
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
        
        if indexPath.item == listData.count + 1{
            self.homeController?.googleSignIn()
            
        }else if indexPath.item > 0 {
            self.homeController?.showControllerForSetting(playListName: listData[indexPath.item - 1]["name"] as! String,id: listData[indexPath.item - 1]["id"] as! Int)
        }
    }
    
    
}
