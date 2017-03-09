//
//  SearchCellSearch.swift
//  MyYoutube
//
//  Created by Leo on 2017/2/26.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class SearchCellForSearch: BaseCell ,UITextFieldDelegate{
    
    var searchCell: SearchCell!
    
    static let shared = SearchCellForSearch()
    
    let inputButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "Search"), for: .normal)
        b.backgroundColor = .gray
        return b
    }()
    
    let inputField: UITextField = {
        let inp = UITextField()
        inp.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return inp
    }()
    
    override func setupView() {
        super.setupView()
        if let keyWindow = UIApplication.shared.keyWindow {
            frame = CGRect(x: 0, y: 110, width: keyWindow.frame.width, height: 50)
        }
        
        inputField.delegate = self
        
        inputButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        addSubview(inputField)
        addSubview(inputButton)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(34)][v1]-16-|", views: inputButton,inputField)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: inputField)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: inputButton)
        
    }
    
    func handleSearch(){
    
        if inputField.text != "" {
            
            let searchString = inputField.text?.replacingOccurrences(of: " ", with: "+")

            YoutubeApi.sharedInstance.search(searchString: searchString!)
        
            searchCell.searchString = searchString
            
            searchCell.fetchVideos()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.endEditing(true)
        return true
    }
}
