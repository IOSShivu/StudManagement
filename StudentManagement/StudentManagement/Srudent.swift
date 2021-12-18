//
//  Srudent.swift
//  StudentManagement
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Student
{
    var spid:Int = 0
    var name:String = ""
    var address:String = ""
    var cls:String = ""
    var pwd:String = ""
    var gender:String = ""
    
    init(id:Int,name:String,address:String,cls:String,pwd:String,gender:String)
    {
        self.spid=id
        self.name=name
        self.address=address
        self.cls=cls
        self.pwd=pwd
        self.gender=gender
        

    }
    
}
