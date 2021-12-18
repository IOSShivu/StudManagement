//
//  AdminDashboard.swift
//  StudentManagement
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminDashboard: UIViewController {
    private let studButton: UIButton = {
        let button = UIButton();
        button.setTitle("Student", for: .normal)
        button.addTarget(self, action: #selector(stud), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let noticeButton: UIButton = {
        let nbutton = UIButton();
        nbutton.setTitle("NoticeBoard", for: .normal)
        nbutton.addTarget(self, action: #selector(notice), for: .touchUpInside)
        nbutton.tintColor = .white
        nbutton.backgroundColor = .black
        nbutton.layer.cornerRadius = 6
        return nbutton
    }()
    private let searchButton: UIButton = {
        let nbutton = UIButton();
        nbutton.setTitle("Search Student", for: .normal)
        nbutton.addTarget(self, action: #selector(searchstudent), for: .touchUpInside)
        nbutton.tintColor = .white
        nbutton.backgroundColor = .black
        nbutton.layer.cornerRadius = 6
        return nbutton
    }()
    
    @objc func stud()
    {
        let d1 = ListStudent()
        navigationController?.pushViewController(d1, animated: true)    }
    
    @objc func notice()
    {
       let n1 = ListNoticeViewController()
        navigationController?.pushViewController(n1, animated: true)
    }
    @objc func searchstudent()
    {
        let n1 = SearchStudent()
        navigationController?.pushViewController(n1, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(studButton)
        view.addSubview(noticeButton)
        view.addSubview(searchButton)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        studButton.frame = CGRect(x: 50, y: 250, width: view.width - 120, height: 40)
        noticeButton.frame = CGRect(x: 50, y: studButton.bottom + 10, width: view.width - 120, height: 40)
        searchButton.frame = CGRect(x: 50, y: noticeButton.bottom + 10, width: view.width - 120, height: 40)
    }
    }
    

