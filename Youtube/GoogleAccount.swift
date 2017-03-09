//
//  YoutubeAccount.swift
//  Youtube
//
//  Created by Leo on 2017/3/1.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit

class GoogleAccount: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var data: Array<Dictionary<String,AnyObject>> = []
    
    let moc = CoreDataCommand(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var accountCell:AccountCell!
    
    let signinbutton: GIDSignInButton = {
        let b = GIDSignInButton()
        return b
    }()
    
    let signoutButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .clear
        b.setTitleColor(.blue, for: .normal)
        b.setTitle("SignOut", for: .normal)
        return b
    }()
    
    let text: UITextView = {
        let t = UITextView()
        return t
    }()
    
    let showYoutubePlayList: UILabel = {
        let l = UILabel()
        return l
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    
    func refreshInterface() {
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            signinbutton.isHidden = true
            signoutButton.isHidden = false
            text.text = "Welcome  \(currentUser.profile.name!)"
            let wid = text.text.characters.count
            let width = view.frame.width
            text.frame = CGRect(x: Int(width / 2 - 50), y: 10, width: (wid * 8), height: 50)
            
        } else {
            collectionView.reloadData()
            signinbutton.isHidden = false
            signoutButton.isHidden = true
            text.text = "Please SignIn"
            let wid = text.text.characters.count
            let width = view.frame.width
            text.frame = CGRect(x: Int(width / 2 - 50), y: 10, width: (wid * 8), height: 50)
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = []
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        let scope: NSString = "https://www.googleapis.com/auth/youtube.readonly"
        let currentScopes: NSArray = GIDSignIn.sharedInstance().scopes as NSArray
        GIDSignIn.sharedInstance().scopes = currentScopes.adding(scope)
        
        view.backgroundColor = .white
        
        view.addSubview(text)
        view.addSubview(collectionView)
        view.addSubview(signoutButton)
        view.addSubview(signinbutton)
        
        let height = view.frame.height
        let width = view.frame.width
        let heigh = Int(height - 120) % 50
        
        signinbutton.frame = CGRect(x: width / 2 - 50, y: height / 2, width: 100, height: 40)
        collectionView.frame = CGRect(x: 10, y: 85, width: Int(width - 20), height: Int(height - 120) - heigh)
        signoutButton.frame = CGRect(x: 10, y: 35, width: 100, height: 50)
        text.frame = CGRect(x: width / 2 - 50, y: 10, width: 100, height: 50)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(myPlayListCell.self, forCellWithReuseIdentifier: "cellId")
        
        signoutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        
        refreshInterface()
        
        (UIApplication.shared.delegate as! AppDelegate).signInCallback = refreshInterface
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print("sign-in-error \(error)")
        } else {
            print("sign-in  \(user)")
            
            user.authentication.getTokensWithHandler { (auth, error) in
                if error != nil{
                    print("error:  \(error)")
                    return
                }
                
                YoutubeApi.sharedInstance.getMyPlayList(string: (auth?.accessToken)!)
                self.data = YoutubeApi.sharedInstance.searchData!
                YoutubeApi.sharedInstance.searchData = nil
                self.collectionView.reloadData()
            }
        }
        refreshInterface()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! myPlayListCell
        
        cell.titleData = self.data[indexPath.item]["title"] as! String!
        
        cell.setup()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let number = moc.loadPlayListId() + 1
        if moc.insert(myEntityName: "CoreDataPlayList", attributeInfo: ["id":number,"name":data[indexPath.item]["title"] as! String]){
            YoutubeApi.sharedInstance.playList(string: data[indexPath.item]["channelId"] as! String)
            let count = YoutubeApi.sharedInstance.searchData?.count
            for i in 0 ..< count! {
                if moc.insert(myEntityName: "CoreDataVideo", attributeInfo: ["name":YoutubeApi.sharedInstance.searchData?[i]["title"]!,"playlistid":number,"videoid":YoutubeApi.sharedInstance.searchData?[i]["videoId"]!]) {
                }
            }
            accountCell.reload()
            Hint.shared.showOneLineMessage(message: "insert \(data[indexPath.item]["title"]!)")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func handleSignOut(){
        GIDSignIn.sharedInstance().signOut()
        self.data = []
        refreshInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

