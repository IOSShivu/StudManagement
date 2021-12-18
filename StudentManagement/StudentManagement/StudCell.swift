//
//  StudCell.swift
//  StudentManagement
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudCell: UITableViewCell {

    private let mylbl : UILabel = {
    
    let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize:15)
        return lbl
    }()
    
    func setupCellWith(student stud: Student)
    {
        contentView.addSubview(mylbl)
        mylbl.frame = CGRect(x: 20, y: 20, width: 300, height: 40)
        mylbl.text = "\(stud.spid)  \(stud.name)  \(stud.address)  \(stud.cls)  \(stud.gender)"
    }

}
