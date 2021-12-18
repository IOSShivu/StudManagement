//
//  AddNotice.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddNotice: UIViewController {

    var note : Notice?
    private var titletxt : UITextField = {
        let txt = UITextField()
        txt.placeholder =  "Enter Title"
        txt.textAlignment = .center
        txt.backgroundColor = .lightGray
        txt.layer.cornerRadius = 5
        return txt
    }()
    private var desctxt : UITextField = {
        let txt = UITextField()
        txt.placeholder =  "Enter Description"
        txt.textAlignment = .center
        txt.backgroundColor = .lightGray
        txt.layer.cornerRadius = 5
        return txt
    }()
    private let addButton: UIButton = {
        let button = UIButton();
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    @objc func add()
    {
       
        let title=titletxt.text!
        let desc=desctxt.text!
       
    
        
        /*if let note = note{
        
        let n = Notice(id:0, title: title, desc: desc)
            update(note : n)
        }
       else
       {
        let n = Notice(id:0, title: title, desc: desc)
        insert(note : n)
       }*/
        if let n = note{
            let note = Notice(id:0, title: title, desc: desc)
            update(note : note)
        }
        else
        {
            let note = Notice(id:0, title: title, desc: desc)
            insert(note : note)
        }
    
        
    }
    func insert(note: Notice)
    {
        SQLiteHandler.shared.insertNotice(note: note){ suceess in
            if suceess{
                print("Insert")
                self.resetFeilds()
            }
            else
            {
                print("Not insert")
                self.resetFeilds()
            }
        }
    }
    
    func update(note: Notice)
    {
        SQLiteHandler.shared.updateNotice(note: note){ suceess in
            if suceess{
                print("Update")
                self.resetFeilds()
            }
            else
            {
                print("Not update")
                self.resetFeilds()
            }
        }
    }
    func resetFeilds()
    {
        titletxt.text = ""
        desctxt.text = ""
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titletxt)
        view.addSubview(desctxt)
        view.addSubview(addButton)
        
        if let note = note{
            titletxt.text = note.title
            desctxt.text = note.desc
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titletxt.frame = CGRect(x: 40, y: 90, width: view.width - 100, height: 40)
        desctxt.frame = CGRect(x: 40, y: titletxt.bottom + 10, width: view.width - 100, height: 40)
        addButton.frame = CGRect(x: 40, y: desctxt.bottom + 10, width: view.width - 100, height: 40)
    }
}
