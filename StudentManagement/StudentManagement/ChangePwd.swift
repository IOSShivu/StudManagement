//
//  ChangePwd.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ChangePwd: UIViewController {
    private var oldpwd : UITextField = {
        let txt = UITextField()
        txt.placeholder =  "Enter Old Password"
        txt.tintColor = .white
        txt.textAlignment = .center
        txt.textColor = .white
        txt.layer.cornerRadius = 5
        txt.backgroundColor = . init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        return txt
    }()
    
    
    private var newpwd : UITextField = {
        let txt = UITextField()
        txt.placeholder =  "Enter New Password"
        txt.textAlignment = .center
        txt.backgroundColor = . init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        txt.tintColor = .white
        txt.textColor = .white

           txt.layer.cornerRadius = 5
        return txt
    }()
    
    private var cpwd : UITextField = {
        let txt = UITextField()
        txt.placeholder =  "Enter Reconfirm Password"
        txt.textAlignment = .center
        txt.textColor = .white

       txt.backgroundColor = . init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        txt.tintColor = .white
        txt.layer.cornerRadius = 5
        return txt
    }()
    private let changeButton: UIButton = {
        let button = UIButton();
        button.setTitle("changePassword", for: .normal)
        button.addTarget(self, action: #selector(changepwd), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    
    @objc func changepwd()
    {
        let id = Int(UserDefaults.standard.integer(forKey: "Id"))
        var stud = [Student]()
        stud = SQLiteHandler.shared.loginstud(for: id)
        var pwd = stud[0].pwd
        var npwd = newpwd.text!
        if(pwd==oldpwd.text)
        {
            if(newpwd.text==cpwd.text)
            {
                SQLiteHandler.shared.changepwd(For: id, For: npwd){success in
                    if success{
                        print("Change")
                    }
                    else
                    {
                        print("not change")
                    }
                }
            }
            else
            {
                print("Password not same")
            }
        }
        else
        {
            print("Wrong password")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        view.addSubview(oldpwd)
        view.addSubview(newpwd)
        view.addSubview(cpwd)
        view.addSubview(changeButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        oldpwd.frame = CGRect(x: 40, y: 80, width: view.width - 100, height: 40)
        newpwd.frame = CGRect(x: 40, y: oldpwd.bottom + 10, width: view.width - 100, height: 40)
        cpwd.frame = CGRect(x: 40, y: newpwd.bottom + 10, width: view.width - 100, height: 40)
        changeButton.frame = CGRect(x: 40, y: cpwd.bottom + 10, width: view.width - 100, height: 40)
    }
   

}
