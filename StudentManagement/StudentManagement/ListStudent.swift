//
//  ListStudent.swift
//  StudentManagement
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ListStudent: UIViewController {

    private var studArray = [Student]();
    
    private let myTableView = UITableView()
    private let toolbar  : UIToolbar = {
      let tbar = UIToolbar()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleadd))
        tbar.items = [add]
        return tbar
    }()
    @objc func handleadd()
    {
        let s1 = AddStudent()
        navigationController?.pushViewController(s1, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "StudentList"
        view.backgroundColor = .white
        view.addSubview(myTableView);
        view.addSubview(toolbar)
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        toolbar.frame  = CGRect(x: 0, y: 60, width: view.width, height: 40)
        myTableView.frame = CGRect(x: 0, y: toolbar.bottom , width: view.width, height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let temp = SQLiteHandler.shared
        studArray = SQLiteHandler.shared.fetch()
    }}
extension ListStudent: UITableViewDataSource,UITableViewDelegate{
    private func setupTableView(){
        myTableView.dataSource = self
        myTableView.delegate   = self
        myTableView.register(StudCell.self, forCellReuseIdentifier: "StudentList")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentList",for: indexPath) as! StudCell
       
            let stud = studArray[indexPath.row]
           cell.setupCellWith(student: stud)
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = studArray[indexPath.row].spid
        
        SQLiteHandler.shared.delete(for: id)
        {
            success in
            if success{
                self.studArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddStudent()
        vc.stud = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

