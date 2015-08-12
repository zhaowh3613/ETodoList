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
    
    var indexOfSelectedTodolist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("TodolistIndex")
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "Todolistindex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init() {
        loadTodolists()
        registerDefaults()
        handleFirstTime()
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
    
    func registerDefaults() {
        let dictionary = ["TodolistIndex": -1, "FirtTime": true]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let todolist = TodoList(name: "my todo list")
            lists.append(todolist)
            indexOfSelectedTodolist = 0
            userDefaults.setBool(false, forKey: "FirstTime")
        }
    }
}
