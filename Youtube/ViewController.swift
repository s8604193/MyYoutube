//
//  ViewController.swift
//  first
//
//  Created by Leo on 2017/2/2.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId: String = "cellId"
    let searchCellId: String = "searchCellId"
    let accountCellId: String = "accountCellId"
    
    let viewController = GoogleAccount()
    
    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    func handleSearch(){
        
        scrollToMenuIndex(menuIndex: 1)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(index: menuIndex)
        
    }
    
    func setTitleForIndex(index: Int) {
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "\(titles[ Int(index) ])"
        }    }
    
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.viewController = self
        return mb
    }()
    
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = false
        
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0,y: 0,width: view.frame.width - 32,height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(AccountCell.self,forCellWithReuseIdentifier: accountCellId)
        collectionView?.register(RecommandCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: searchCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
        if let keyWindow = UIApplication.shared.keyWindow {
            if Int(scrollView.contentOffset.x) == 320 {
                keyWindow.addSubview(SearchCellForSearch.shared)
            } else {
                SearchCellForSearch.shared.removeFromSuperview()
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1 {
            
            identifier = searchCellId
            
        } else if indexPath.item == 2 {
        
            identifier = accountCellId
            
        } else {
            
            identifier = cellId
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if indexPath.item == 2 {
            viewController.accountCell = (cell as! AccountCell)
            (cell as! AccountCell).homeController = self
        } else if indexPath.item == 1 {
            SearchCellForSearch.shared.searchCell = (cell as! SearchCell)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height - 50 )
    }
    
    let titles = ["Home", "Search", "My Playlist"]
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index),section :0)
        
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))
    }
    
    func googleSignIn() {
        viewController.navigationItem.title = "GoogleAccount"
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func showControllerForSetting(playListName: String,id: Int) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = playListName
        navigationController?.pushViewController(viewController, animated: true)
        
        let listViewCell = ShowPlayListCelll()
        listViewCell.playListId = id
        listViewCell.nav = navigationController.self
        listViewCell.viewController = self
        listViewCell.setup()
        viewController.view = listViewCell
    }
}

