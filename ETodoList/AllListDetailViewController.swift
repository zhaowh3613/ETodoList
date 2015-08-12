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

class AllListDetailViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: AllListDetailViewControllerDelegate?
    var allListToEdit: TodoList?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let item = allListToEdit {
            title = "Edit TodoList"
            textField.text = item.name
            doneButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func done(sender: UIButton) {
        if let todolist = allListToEdit {
            todolist.name = textField.text
            delegate?.allListDetailViewController(self,didFinishEditingTodoList: todolist)
        } else {
            let todolist = TodoList(name: textField.text)
            delegate?.allListDetailViewController(self, didFinishAddingTodoList: todolist)
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        delegate?.allListDetailViewControllerDidCancel(self)
    }
}
