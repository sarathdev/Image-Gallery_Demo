//
//  DBHandlerClass.swift
//  PhotoFlickr_Demo
//
//  Created by Sarath on 27/05/17.
//  Copyright © 2017 Xcoder. All rights reserved.
//

import UIKit
import SQLite

class DBHandlerClass: NSObject {

      // MARK: Shared Instance
    
    static let shared = DBHandlerClass()
    
    
    func getDBConnection() -> Connection {
        let dbpath : String? = Bundle.main.path(forResource: "image", ofType: "sqlite")! as String?
        
        //        let path = NSSearchPathForDirectoriesInDomains(
        //            .documentDirectory, .userDomainMask, true
        //            ).first!
        //        let dbpath = path.appending("image.sqlite")
        
        var db : Connection!
        do {
            db = try Connection(dbpath!, readonly: false)
            
        } catch {
            print("Error")
        }
        
        
        print("DB path \(db)")
        return db as Connection
    }
    
    func dbBusyHandler() -> Bool    {
        let db : Connection = getDBConnection()
        
        db.busyTimeout = 5
        
        db.busyHandler({ tries in
            if tries >= 3 {
                return false
            }
            return true
        })
        return false
    }
    
    func getTotalImagesCount() -> Swift.Int64! {
        var count : Swift.Int64? = 0
        let db : Connection = getDBConnection()
        do {
            count = try db.scalar("SELECT count(*) FROM ImageTable") as? Swift.Int64
            
        } catch  {
            print("Error")
        }
        
        return count;
    }
    
    func insertData(data : ImageTable) -> Void {
        
        let db : Connection = getDBConnection()
        
        let imageTable = Table("ImageTable")
        let url = Expression<String>("url")
        let lk = Expression<Int64>("lk")
        let dislike = Expression<Int64>("dislike")
        let click = Expression<Int64>("click")
        let updated_at = Expression<String>("updated_at")
        let created_at = Expression<String>("created_at")

        let insertData = imageTable.insert(url <- data.url, lk <- data.lk,dislike <- data.dislike, click <- data.click, updated_at <- data.updated_at, created_at <- data.created_at)
        do {
            try db.run(insertData)
        } catch  {
            
        }
        
    }
    
    
    func getImageTableData() -> NSMutableArray {
        let array : NSMutableArray! = NSMutableArray()
        do {
            
            for imageData in try getDBConnection().prepare("SELECT * FROM ImageTable order by click DESC")
            {
 
                let row : ImageTable = ImageTable()
                row.id_value = imageData[0] as! Int64
                row.url = imageData[1] as! String
                row.lk = imageData[2] as! Int64
                row.dislike = imageData[3] as! Int64
                row.click = imageData[4] as! Int64
                row.updated_at = imageData[5] as! String
                row.created_at = imageData[6] as! String

                array.add(row)
            }
        } catch  {
            print("Error")
        }
        /*
        if array.count != 0 {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "click", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            let sortedResults = array.sortedArray(using: [descriptor])
            
            array.removeAllObjects()

            array.addObjects(from: sortedResults )
        }
        */
        
        return array;
        
    }
    
    func updateImageTableData(data: ImageTable) -> Void {
        
        let db : Connection = getDBConnection()
        
        let imageTable = Table("ImageTable")
        let url = Expression<String>("url")
        let lk = Expression<Int64>("lk")
        let dislike = Expression<Int64>("dislike")
        let click = Expression<Int64>("click")
        let updated_at = Expression<String>("updated_at")
        let idField = Expression<Int64>("id")
        let created_at = Expression<String>("created_at")

        let alice = imageTable.filter(idField == data.id_value)
        
        let updateData = alice.update(url <- data.url, lk <- data.lk,dislike <- data.dislike, click <- data.click, updated_at <- data.updated_at, created_at <- data.created_at)
        do {
            try db.run(updateData)
        } catch  {
            
        }
    }

    
    
}
