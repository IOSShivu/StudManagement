//
//  SearchStudent.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class SearchStudent: UIViewController {

    private var studArray = [Student]()
    
    private let myTableView = UITableView()
    private let mlbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Select Class"
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    private let mysegment : UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "FY", at: 0, animated: true)
        segment.insertSegment(withTitle: "SY", at: 1, animated: true)
         segment.insertSegment(withTitle: "TY", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.tintColor = .blue
        return segment
        
    }()
    private let showButton: UIButton = {
        let button = UIButton();
        button.setTitle("Show", for: .normal)
        button.addTarget(self, action: #selector(showdata), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    @objc func showdata()
    {
        var cls = mysegment.titleForSegment(at: mysegment.selectedSegmentIndex)!

        studArray = SQLiteHandler.shared.searchstud(for: cls)
        setupTableView()
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mlbl)
        view.addSubview(mysegment)
        view.addSubview(showButton)
        view.addSubview(myTableView);
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mlbl.frame = CGRect(x: 20, y: 80, width: 100, height: 40)
        mysegment.frame = CGRect(x: mlbl.right + 5, y: 80, width: 200, height: 40)
         showButton.frame = CGRect(x: 40, y: mysegment.bottom + 10, width: view.width - 100, height: 40)
        myTableView.frame = CGRect(x: 0, y: showButton.bottom , width: view.width, height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom)
    }

}
extension SearchStudent: UITableViewDataSource,UITableViewDelegate{
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
   
}




