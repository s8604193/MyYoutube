//
//  ShowPlayListCell.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit
class ShowPlayListCelll: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var viewController: ViewController!
    
    var nav: UINavigationController!
    
    var playListId: Int!
    
    var listData: [Dictionary<String,AnyObject>] = []
    
    var collectionView: UICollectionView!
    
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    override func setupView() {
        super.setupView()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0.5
        
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        
        backgroundColor = .white
        
        addSubview(collectionView)
        addSubview(view)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(cellToSearch.self, forCellWithReuseIdentifier: "newplaylist")
        collectionView.register(VideoListCell.self, forCellWithReuseIdentifier: "cellid")
        
        
    }
    
    func reload(){
        
        setup()
        
        collectionView.reloadData()
    }
    
    func setup(){
        
        if let listData = moc.loadVideo(playListId: playListId) {
            self.listData = listData
        }
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
            (cell as! VideoListCell).controller = self
            
            (cell as! VideoListCell).playListId = self.playListId
            
            (cell as! VideoListCell).playListData = listData[indexPath.item - 1]
            
            (cell as! VideoListCell).setupCell()
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
            
            let cell = Launcher()
            
            cell.listLauncher(list: listData, playingId: (indexPath.item - 1))
            
        } else if indexPath.item == 0{
        
            nav.popViewController(animated: true)
            viewController.scrollToMenuIndex(menuIndex: 1)
        }
    }
    
}

class cellToSearch: BaseCell {

    let title: UIButton = {
        let tl = UIButton()
        tl.setImage(UIImage(named: "Add"), for: .normal)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()

    override var isHighlighted: Bool{
        didSet{
            
            title.backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
        }
    }
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = .white
        
        addSubview(title)
        
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalToConstant: 20).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
