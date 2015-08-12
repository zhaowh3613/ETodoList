//
//  File.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/10.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import Foundation

class TodolistItem: NSObject, NSCoding{
    var title: String
    var isChecked: Bool = false
    
    init(title: String, isChecked: Bool){
        self.title = title
        self.isChecked = isChecked
        super.init()
    }
    
    func toggleChecked(){
        
        isChecked = !isChecked
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(isChecked, forKey: "isChecked")
    }
    
    required init(coder aDecoder: NSCoder){
        title = aDecoder.decodeObjectForKey("title") as! String
        isChecked = aDecoder.decodeObjectForKey("isChecked") as! Bool
        super.init()
    }
}



