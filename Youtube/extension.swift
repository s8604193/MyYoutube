//
//  extension.swift
//  youtube
//
//  Created by Leo on 2017/2/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255,green: green/255,blue: blue/255,alpha: 1)
    }
    
}
extension UILabel{
    func changeLineSpace(space:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: .init(location: 0, length: (text?.characters.count)!))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}
extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
    
}
class ClickButton: UIButton {
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.rgb(red: 230, green: 230, blue: 230) : UIColor.white
        }
    }
}
class BaseCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){}
    
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomerImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsinUrlString(string: String) {
        
        imageUrlString = string
        
        let url = NSURL(string: string)
        
        image = nil
        
        if let imageFromCache = (imageCache.object(forKey: string as NSString) )as? UIImage
        {
            self.image = imageFromCache
            
            return
            
        }
        
        URLSession.shared.dataTask(with: url as! URL, completionHandler:  {
            (data, response, error) in
            
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == string {
                    self.image = imageToCache
                }
                
                
                //imageCache.setObject(imageToCache!, forKey: string  as NSString)
            })
            
        }).resume()
    }
    
}
