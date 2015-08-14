//
//  AllListDetailViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/8/9.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

protocol AllListDetailViewControllerDelegate: class {
    
    func allListDetailViewControllerDidCancel(controller: AllListDetailViewController)
    
    func allListDetailViewController(controller: AllListDetailViewController,didFinishAddingTodoList todolist: TodoList)
    
    func allListDetailViewController(controller: AllListDetailViewController,didFinishEditingTodoList todoList: TodoList)
}

class AllListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    weak var delegate: AllListDetailViewControllerDelegate?
    var iconName = "Folder"
    var allListToEdit: TodoList?
    
    @IBOutlet weak var iconNameLabel: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
   
    func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String) {
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let item = allListToEdit {
            title = "Edit TodoList"
            textField.text = item.name
            doneButton.enabled = true
            iconName = item.iconName
        }
        iconImageView.image = UIImage(named: iconName)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickIconSegue" {
            let controller = segue.destinationViewController as! IconPickerViewController
            controller.delegate = self
        }
    }
    
    @IBAction func done(sender: UIButton) {
        if let todolist = allListToEdit {
            todolist.name = textField.text
            todolist.iconName = iconName
            delegate?.allListDetailViewController(self,didFinishEditingTodoList: todolist)
        } else {
            let todolist = TodoList(name: textField.text)
            todolist.iconName = iconName
            delegate?.allListDetailViewController(self, didFinishAddingTodoList: todolist)
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        delegate?.allListDetailViewControllerDidCancel(self)
    }
}
