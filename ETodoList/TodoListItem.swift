//
//  File.swift
//  ETodoList
//
//  Created by Wenhui Zhao on 15/5/10.
//  Copyright (c) 2015年 Wenhui Zhao. All rights reserved.
//

import Foundation

class TodolistItem :NSObject{
    var title: String
    var isChecked: Bool
    init(title: String, isChecked: Bool){
    
        
        self.title = title
        self.isChecked = isChecked
        super.init()
    }
    
    func toggleChecked(){
    
        isChecked = !isChecked
    }
}



