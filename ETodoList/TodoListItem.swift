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
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID: Int
    
    
    init(title: String, isChecked: Bool){
        self.title = title
        self.isChecked = isChecked
        itemID = DataModel.nextTodolistItemID()
        super.init()
    }
    
    func toggleChecked(){
        
        isChecked = !isChecked
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(isChecked, forKey: "isChecked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(itemID, forKey: "ItemID")
    }
    
    required init(coder aDecoder: NSCoder){
        title = aDecoder.decodeObjectForKey("title") as! String
        isChecked = aDecoder.decodeObjectForKey("isChecked") as! Bool
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID")
        super.init()
    }
}



