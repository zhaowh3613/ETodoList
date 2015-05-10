//
//  AddItemViewController.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/10.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    @IBAction func cancelSave(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func SaveItem(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
