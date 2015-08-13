//
//  TodoList.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/28.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class TodoList: NSObject, NSCoding {
    var name: String = ""
    var items = [TodolistItem]()
    
    init(name: String) {
        self.name = name
       // self.item = item
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = (aDecoder.decodeObjectForKey("Name") as? String)!
        items = aDecoder.decodeObjectForKey("Items") as! [TodolistItem]
    }
    
    func countUncheckedItems() -> Int {
//        var count = 0
//        for item in items {
//            if !item.isChecked {
//                count += 1
//            }
//        }
//        return count
        return reduce(items, 0) { cnt, item in cnt + (item.isChecked ? 0 : 1)}
    }
    
}
