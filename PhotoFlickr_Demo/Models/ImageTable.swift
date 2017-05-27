//
//  ImageTable.swift
//  PhotoFlickr_Demo
//
//  Created by Sarath on 27/05/17.
//  Copyright © 2017 Xcoder. All rights reserved.
//

import UIKit

class ImageTable: NSObject {
/*
     Column Name
     Type
     Use of Column
     id
     
     INTEGER
     unique id
     url
     TEXT
     Image Url
     lk
     
     INTEGER
     Like Count
     dislike
     INTEGER
     Dislike Count
     click
     INTEGER
     Click Count
     updated_at
     DATE
     Last Updated Time
 */
    
    public var url : String!
    public var dislike : Int64!
    public var lk: Int64!
    public var click: Int64!
    public var id_value: Int64!
    public var updated_at : String!
    public var created_at : String!
    
}
