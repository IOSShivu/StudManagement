//
//  Notice.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Notice
{
    var id : Int = 0
    var title : String = ""
    var desc : String = ""
    
    init(id:Int,title:String,desc:String)
    {
        self.id = id
        self.title = title
        self.desc = desc
    }
}
