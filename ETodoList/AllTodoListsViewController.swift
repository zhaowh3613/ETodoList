//
//  AllTodoListsViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/27.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class AllTodoListsViewController: UITableViewController, AllListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    func allListDetailViewControllerDidCancel(controller: AllListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func allListDetailViewController(controller: AllListDetailViewController,didFinishAddingTodoList todolist: TodoList) {
        let newIndex = dataModel.lists.count
        dataModel.lists.append(todolist)
        let indexPath = NSIndexPath(forRow: newIndex, inSection: 0)
        var indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        //SaveTodolists()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func allListDetailViewController(controller: AllListDetailViewController,didFinishEditingTodoList todolist: TodoList) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    init(){
//        Lists = Array<TodoList>()
//        super.init()
//    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedTodolist
        println("TodolistIndex = \(index)")
        if index >= 0 && index < dataModel.lists.count {
            let todolist = dataModel.lists[index]
            performSegueWithIdentifier("ShowTodoList", sender: todolist)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataModel.lists.count
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("listDetailNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! AllListDetailViewController
        controller.delegate = self
        var todolist = dataModel.lists[indexPath.row]
        controller.allListToEdit = todolist
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ETodoListsItem") as? UITableViewCell
        if cell == nil {
          cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "ETodoListsItem")
        }
        var item = dataModel.lists[indexPath.row]
        cell!.textLabel!.text = item.name
        cell!.accessoryType = .DetailDisclosureButton
        return cell!
    }
    
    func configCheckMarkForCell(cell: UITableViewCell, withCheckItem item: TodoList) {
        let label = cell.viewWithTag(1) as! UILabel
        label.text = item.name
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedTodolist = indexPath.row
        let listItem = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowTodoList", sender: listItem)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTodoList" {
            let controller = segue.destinationViewController as! ETodoListViewController
            controller.todolist = sender as! TodoList
        } else if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AllListDetailViewController
            controller.delegate = self
            controller.allListToEdit = nil
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        var indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
           dataModel.indexOfSelectedTodolist = -1
        }
    }

}
