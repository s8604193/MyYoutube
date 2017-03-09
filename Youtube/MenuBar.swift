//
//  MenuBar.swift
//  first
//
//  Created by Leo on 2017/2/5.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    let imageName = ["Home", "Search", "Account"]
    
    var viewController: ViewController?
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let indexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath as IndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
        
    }
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95,alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //make numbers of object
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    //the cell object
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!MenuCell
        cell.image.image = UIImage(named: imageName[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3,height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
class MenuCell: BaseCell{
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Home")
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet {
            image.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            image.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override func setupView(){
        super.setupView()
        addSubview(image)
        addConstraintsWithFormat(format: "H:[v0(20)]", views: image)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: image)
        addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
    
}
