//
//  ViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/9.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class ETodoListViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var todolist: TodoList!
    
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: TodolistItem){
        let newIndex = todolist.items.count
        todolist.items.append(item)
        let indexPath = NSIndexPath(forRow: newIndex, inSection: 0)
        var indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: TodolistItem){
        if let index = find(todolist.items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureCheckmarkForCell(cell, withCheckItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        title = todolist.name
        //Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todolist.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ETodoListItem") as! UITableViewCell
        var item = todolist.items[indexPath.row]
        configureCheckmarkForCell(cell, withCheckItem: item)
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
        var item = todolist.items[indexPath.row]
        item.toggleChecked()
        configureCheckmarkForCell(cell, withCheckItem: item)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withCheckItem item: TodolistItem){
        let checkLabel = cell.viewWithTag(2) as! UILabel
        if item.isChecked{
        
            checkLabel.text = "✓"
        }else{
        
            checkLabel.text = ""
        }
        var isChecked = item.isChecked ? 1: 0
        let attributedText = NSAttributedString(string: item.title, attributes: [NSStrikethroughStyleAttributeName: isChecked])
        var titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.attributedText = attributedText
        //saveListItems()
    }
    
    @IBAction func AddItem(sender: UIBarButtonItem) {
        let newIndex = todolist.items.count
        todolist.items.append({TodolistItem(title: "new line", isChecked: false)}())
        let indexPath = NSIndexPath(forRow: newIndex, inSection: 0)
        var indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        todolist.items.removeAtIndex(indexPath.row)
        var indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    /*1. Because there may be more than one segue per view controller, it’s a good idea to give each one a unique identifier and to check for that identifier first to make sure you’re handling the correct segue. Swift’s == comparison operator does not work on just numbers but also on strings and most other types of objects.
    2. The new view controller can be found in segue.destinationViewController. The storyboard shows that the segue does not go directly to AddItemViewController but to the navigation controller that embeds it. So first you get ahold of this UINavigationController object.
    3. To find the AddItemViewController, you can look at the navigation controller’s topViewController property. This property refers to the screen that is currently active inside the navigation controller.
    4. Once you have a reference to the AddItemViewController object, you set its delegate property to self and the connection is complete. Note that “self” here refers to the ChecklistViewController.*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "AddItemSegue"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
        }else if segue.identifier == "EditItemSegue"{
           let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
               controller.itemEdit = todolist.items[indexPath.row]
            }
        }
    }
    
    func documentDirectory() -> String{
        let path = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        return path[0]
    }
    
    func filePath() -> String{
        return documentDirectory().stringByAppendingPathComponent("ETodoList.plist")
    }
    
}
