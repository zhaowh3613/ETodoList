//
//  AddItemViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/10.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class{

   func addItemViewControllerDidCancel(controller: AddItemViewController)

   func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: TodolistItem)
    
   func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: TodolistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    weak var delegate: AddItemViewControllerDelegate?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var itemEdit: TodolistItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        if let item = itemEdit{        
            title = "EditItem"
            textField.text = item.title
            doneButton.enabled = true;
        }
    }
    
    
    @IBAction func cancelSave(sender: UIButton) {
        delegate?.addItemViewControllerDidCancel(self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveItem(sender: UIButton) {
        if let item = itemEdit {
            item.title = textField.text
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        } else {
            var newItem = TodolistItem(title: textField.text, isChecked: false)
            delegate?.addItemViewController(self, didFinishAddingItem: newItem)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func keyDone(sender: UITextField) {
        var newItem = TodolistItem(title: textField.text, isChecked: false)
        delegate?.addItemViewController(self, didFinishAddingItem: newItem)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
    
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneButton.enabled = (newText.length > 0)
        return true
    }
    
}
