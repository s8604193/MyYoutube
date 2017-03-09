//
//  PlayListCell.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class PlayListCell: BaseCell {

    var controller: BaseCell!
    
    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var playListData: Dictionary<String,AnyObject>!
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .center
        return tl
    }()
    
    let deleteLabel: UIButton = {
        let dl = UIButton()
        dl.setImage(UIImage(named: "Cancel"), for: .normal)
        dl.backgroundColor = .clear
        return dl
    }()
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel.backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
            
            deleteLabel.backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
            
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
        }
        
    }
    
    func handleDelete(){
        
        if moc.deleteplayList(playListId: playListData["id"] as! Int) {
            Hint.shared.showOneLineMessage(message: "delete success")
            (controller as! AccountCell).reload()
            
        } else{
            Hint.shared.showOneLineMessage(message: "delete fail")
        }
        
    }
    
    override func setupView(){
    
        layer.borderWidth = 1
        layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        
        super.setupView()
        
        backgroundColor = .white
        
        deleteLabel.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(deleteLabel)
        
        let width = frame.width - 35
        
        addConstraintsWithFormat(format: "H:|-10-[v0(10)]-15-[v1(\(width))]|", views: deleteLabel,titleLabel)
        addConstraintsWithFormat(format: "V:|-15-[v0(10)]|", views: deleteLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(frame.height))]|", views: titleLabel)
    }
    
    func setupCell(){
    
        titleLabel.text = playListData["name"] as? String
        
    }
}
