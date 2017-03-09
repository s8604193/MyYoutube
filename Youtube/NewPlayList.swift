//
//  NewPlayList.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class NewPlayList: BaseCell ,UITextFieldDelegate{

    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var controller: AccountCell!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
            image.backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
        
        }
    }
    
    let confirmButton: ClickButton = {
        let bn = ClickButton()
        bn.setTitleColor(.black, for: .normal)
        bn.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        bn.layer.borderWidth = 0.5
        bn.translatesAutoresizingMaskIntoConstraints = false
        bn.setTitle("confirm", for: .normal)
        return bn
    }()
    
    let cancelButton: ClickButton = {
        let bn = ClickButton()
        bn.setTitleColor(.black, for: .normal)
        bn.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        bn.layer.borderWidth = 0.5
        bn.translatesAutoresizingMaskIntoConstraints = false
        bn.setTitle("cancel", for: .normal)
        return bn
    }()
    
    let inputBoxTitle: UILabel = {
        let ib = UILabel()
        ib.text = "New  PlayList"
        ib.textAlignment = .center
        return ib
    }()
    
    let line: UILabel = {
        let l = UILabel()
        l.backgroundColor = .black
        return l
    }()
    
    let inputField: UITextField = {
        let inp = UITextField()
        inp.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        inp.layer.borderColor = UIColor.black.cgColor
        return inp
    }()
    
    
    let blackView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .black
        bv.alpha = 0.8
        return bv
    }()
    
    let inputBox: UIView = {
        let ib = UIView()
        ib.backgroundColor = .white
        return ib
    }()
    
    let image: UIImageView = {
        let lb = UIImageView()
        lb.image = UIImage(named: "Add")
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    func handleHide(){
        
        blackView.frame = CGRect(x:0,y:0,width:0,height:0)
        
        inputBox.frame = CGRect(x:0,y:0,width:0,height:0)
        
        blackView.removeFromSuperview()
        
        inputBox.removeFromSuperview()
    
    }
    
    func handleAdd(){
        
        inputField.endEditing(true)
        
        if moc.insert(myEntityName: "CoreDataPlayList", attributeInfo: ["id":(moc.loadPlayListId() + 1),"name":inputField.text]){
            
            Hint.shared.showOneLineMessage(message: "insert success")
            
            inputField.text = ""
        
            handleHide()
            
            controller.reload()
        }
        
        
    }
    
    func handleTap(){
    
        if let keyWindow = UIApplication.shared.keyWindow {
            
            blackView.frame = keyWindow.frame
            
            let height = keyWindow.frame.height
            
            let width = keyWindow.frame.width
            
            inputBox.frame = CGRect(x: (width / 2 - 125), y: (height / 2 - 59), width: 250, height: 118)
            
            keyWindow.addSubview(blackView)
            
            keyWindow.addSubview(inputBox)
            
        }
        
    }
    
    override func setupView() {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        
        inputBox.addSubview(inputBoxTitle)
        inputBox.addSubview(inputField)
        inputBox.addSubview(line)
        inputBox.addSubview(confirmButton)
        inputBox.addSubview(cancelButton)
        
        inputBox.addConstraintsWithFormat(format: "H:|[v0(125)][v1(125)]|", views: confirmButton,cancelButton)
        inputBox.addConstraintsWithFormat(format: "H:|[v0]|", views: line)
        inputBox.addConstraintsWithFormat(format: "H:|[v0]|", views: inputBoxTitle)
        inputBox.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: inputField)
        inputBox.addConstraintsWithFormat(format: "V:|[v0(30)][v1(1)]-8-[v2(30)]-8-[v3(40)]", views: inputBoxTitle,line,inputField,confirmButton)
        inputBox.addConstraintsWithFormat(format: "V:|[v0(30)][v1(1)]-8-[v2(30)]-8-[v3(40)]", views: inputBoxTitle,line,inputField,cancelButton)
        
        cancelButton.addTarget(self, action: #selector(handleHide), for: .touchUpInside)
        
        confirmButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHide)))
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        backgroundColor = .white
        
        addSubview(image)
        
        inputField.delegate = self
        
        let width = frame.width / 2 - 10
        let height = frame.height / 2 - 10
        
        addConstraintsWithFormat(format: "H:|-\(width)-[v0(20)]|", views: image)
        addConstraintsWithFormat(format: "V:|-\(height)-[v0(20)]|", views: image)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.endEditing(true)
        return true
    }
    
}

