//
//  DataModel.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/8/11.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class DataModel {
    var lists = Array<TodoList>()
    
    init() {
        loadTodolists()
    }
    
    func documentsDirectory() ->String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        return path[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("ETodolists.plist")
    }
    
    func saveTodolists () {
        var data = NSMutableData()
        var archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "ETodolists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
        println("saveTodolists")
    }
    
    func loadTodolists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                var unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("ETodolists") as! Array<TodoList>
                unarchiver.finishDecoding()
                println("loadTodolists Data file path is \(dataFilePath())")

            }
        }
    }
}
