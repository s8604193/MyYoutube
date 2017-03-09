//
//  DataBase.swift
//  Youtube
//
//  Created by Leo on 2017/2/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataCommand {
    var moc :NSManagedObjectContext!
    
    init(moc:NSManagedObjectContext) {
        self.moc = moc
    }
    
    func insert(myEntityName:String, attributeInfo:[String:Any]) -> Bool {
        let insetData =
            NSEntityDescription.insertNewObject(
                forEntityName: myEntityName, into: self.moc)
        
        for (key,value) in attributeInfo {
            
            insetData.setValue(value, forKey: key)
            
        }
        
        do {
            try moc.save()
            
            return true
        } catch {
            fatalError("\(error)")
        }
        
        
        return false
    }
    
    func loadVideoId(videoId:String , playListId: Int) -> [Dictionary<String,AnyObject>]? {
        let myEntityName = "CoreDataVideo"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        request.predicate = NSPredicate(format: "videoid = \"\(videoId)\" and playlistid = \(playListId)")
        
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataVideo]
            
            var dictionary: [Dictionary<String,AnyObject>] = []
            
            for var i in results {
                var dic =  Dictionary<String,AnyObject>()
                
                dic["id"] = i.value(forKey: "id") as AnyObject?
                
                dic["name"] = i.value(forKey: "name") as AnyObject?
                
                dictionary.append(dic)
            }
            
            
            return dictionary
        } catch {
            fatalError("\(error)")
        }
        
        return nil
    }
    
    func loadVideo(playListId:Int) -> [Dictionary<String,AnyObject>]? {
        let myEntityName = "CoreDataVideo"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        request.predicate = NSPredicate(format: "playlistid = \(playListId)")
        
        do {
            var results: [CoreDataVideo] = []
            
            results = try moc.fetch(request) as! [CoreDataVideo]
            
            var dictionary: [Dictionary<String,AnyObject>] = []
            
            for var i in results {
                var dic =  Dictionary<String,AnyObject>()
                
                dic["id"] = i.value(forKey: "videoid") as AnyObject?
                
                dic["name"] = i.value(forKey: "name") as AnyObject?
                
                dictionary.append(dic)
            }
            
            
            return dictionary
        } catch {
            fatalError("\(error)")
        }
        
        return nil
    }

    
    func loadPlayList() -> [Dictionary<String,AnyObject>]? {
        let myEntityName = "CoreDataPlayList"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        
        do {
            var results: [CoreDataPlayList] = []
            
            results = try moc.fetch(request) as! [CoreDataPlayList]
            
            var dictionary: [Dictionary<String,AnyObject>] = []
            
            for var i in results {
                var dic =  Dictionary<String,AnyObject>()
                
                dic["id"] = i.value(forKey: "id") as AnyObject?
                
                dic["name"] = i.value(forKey: "name") as AnyObject?
                
                dictionary.append(dic)
            }
            
            
            return dictionary
        } catch {
            fatalError("\(error)")
        }
        
        return nil
    }
    
    func loadPlayListId() -> Int {
        let myEntityName = "CoreDataPlayList"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        request.fetchLimit = 1
        
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataPlayList]
            
            var answer: Int!
            if results.count > 0 {
                for var i in results {
                    answer = i.value(forKey: "id") as! Int!
                }
            } else {
                answer = 0
            }
            
            return answer
        } catch {
            fatalError("\(error)")
        }
        
        return 0
    }
    
    func deleteVideo(playListId: Int,videoId: String) -> Bool {
        let myEntityName = "CoreDataVideo"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        request.predicate = NSPredicate(format: "playlistid = \(playListId) and videoid = \"\(videoId)\"")
        
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataVideo]
            
            for result in results {
                
                moc.delete(result)
            }
            try moc.save()
            
            return true
        } catch {
            fatalError("\(error)")
        }
        
        return false
    }

    func deleteplayList(playListId: Int) -> Bool {
        let myEntityName = "CoreDataPlayList"
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        
        request.predicate = NSPredicate(format: "id = \(playListId)")
        
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataPlayList]
            
            for result in results {
                moc.delete(result)
            }
            try moc.save()
            
            return true
        } catch {
            fatalError("\(error)")
        }
        
        return false
    }
    
    func clear(){
        var myEntityName = "CoreDataPlayList"
        
        var request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataPlayList]
            
            for result in results {
                moc.delete(result)
            }
            try moc.save()
            
        } catch {
            fatalError("\(error)")
        }
        myEntityName = "CoreDataVideo"
        
        request = NSFetchRequest<NSFetchRequestResult>(
            entityName: myEntityName)
        do {
            let results =
                try moc.fetch(request)
                    as! [CoreDataVideo]
            
            for result in results {
                moc.delete(result)
            }
            try moc.save()
            
        } catch {
            fatalError("\(error)")
        }
    
    
    }
    
    
}
