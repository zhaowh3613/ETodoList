//
//  ViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/9.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class ETodoListViewController: UITableViewController {

    var items = [TodolistItem]()
    
    required init(coder aDecoder: NSCoder){
    
        //var item1:TodolistItem = TodolistItem(title: "books list", isChecked: false)
        items.append({TodolistItem(title: "books list", isChecked: true)}())
        items.append({TodolistItem(title: "cooks list", isChecked: false)}())
        items.append({TodolistItem(title: "buy list", isChecked: false)}())
        items.append({TodolistItem(title: "learnning list", isChecked: false)}())
        items.append({TodolistItem(title: "call list", isChecked: false)}())
//        items = Array<TodolistItem>()
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("ETodoListItem") as! UITableViewCell
        
        var item = items[indexPath.row]
        
        var titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = item.title
        cell.accessoryType = item.isChecked ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
        var item = items[indexPath.row]
        item.toggleChecked()
            if cell.accessoryType == .None{
            
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }else{
            
                cell.accessoryType = .None
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func AddItem(sender: UIBarButtonItem) {
        let newIndex = items.count
        items.append({TodolistItem(title: "new line", isChecked: false)}())
        let indexPath = NSIndexPath(forRow: newIndex, inSection: 0)
        var indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    
        items.removeAtIndex(indexPath.row)
        var indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    
}

