//
//  StudentHome.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudentHome: UIViewController {
    private let vprofileButton: UIButton = {
        let button = UIButton();
        button.setTitle("View Profile", for: .normal)
        button.addTarget(self, action: #selector(vprofile), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = . init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let cpwdeButton: UIButton = {
        let nbutton = UIButton();
        nbutton.setTitle("change Password", for: .normal)
        nbutton.addTarget(self, action: #selector(changepwd), for: .touchUpInside)
        nbutton.tintColor = .white
        nbutton.backgroundColor =  .init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        nbutton.layer.cornerRadius = 6
        return nbutton
    }()
    
    private let noticeButton: UIButton = {
        let nbutton = UIButton();
        nbutton.setTitle("View Notice", for: .normal)
        nbutton.addTarget(self, action: #selector(notice), for: .touchUpInside)
        nbutton.tintColor = .white
        nbutton.backgroundColor =  .init(red: 50.0/255, green: 45.0/255, blue: 65.0/255, alpha: 1.0)
        nbutton.layer.cornerRadius = 6
        return nbutton
    }()
    @objc func vprofile()
    {
        let id = Int(UserDefaults.standard.integer(forKey: "Id"))
        var stud = [Student]()
        stud = SQLiteHandler.shared.loginstud(for: id)
        var name = stud[0].name
        var cls = stud[0].cls
        var add = stud[0].address
        var gender = stud[0].gender
        let alert = UIAlertController(title: "View Profile", message: " Spid:\(String(id)) \n Name:\(name) \n Address:\(add) \n Class:\(cls) \n Gender:\(gender)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        alert.addAction(ok)
        self.present(alert,animated: true)
    }
    @objc func changepwd()
    {  let d1 = ChangePwd()
        navigationController?.pushViewController(d1, animated: true)
        
    }
    @objc func notice()
    {
        let d1 = ViewNotice()
        navigationController?.pushViewController(d1, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        view.addSubview(vprofileButton)
        view.addSubview(cpwdeButton)
        view.addSubview(noticeButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vprofileButton.frame = CGRect(x: 40, y: 60, width: view.width - 100, height: 40)
        cpwdeButton.frame = CGRect(x: 40, y: vprofileButton.bottom + 10, width: view.width - 100, height: 40)
        noticeButton.frame = CGRect(x: 40, y: cpwdeButton.bottom + 10, width: view.width - 100, height: 40)
    }

}
