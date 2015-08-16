//
//  File.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/10.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import Foundation
import UIKit

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
    
    func scheduleNotification() {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            println("Found an existingNotification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        if shouldRemind && dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = title
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": itemID]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            println("scheduleNotification \(localNotification) for ItemID \(itemID)")
        }
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification]
        for notification in allNotifications {
            if let number = notification.userInfo?["ItemID"] as? NSNumber {
                if number.integerValue == itemID {
                    return notification
                }
            }
        }
        return nil
    }
    
    deinit {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            println("Removing existing notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
}



