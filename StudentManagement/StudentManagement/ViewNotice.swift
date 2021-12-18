//
//  ViewNotice.swift
//  StudentManagement
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewNotice: UIViewController {
    private var noticeArray = [Notice]();
    
    private let myTableView = UITableView()
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NoticeList"
        view.backgroundColor = .white
        view.addSubview(myTableView);
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        myTableView.frame = CGRect(x: 0, y: 60 , width: view.width, height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let temp = SQLiteHandler.shared
        noticeArray = SQLiteHandler.shared.fetchNotice()
    }}
extension ViewNotice: UITableViewDataSource,UITableViewDelegate{
    private func setupTableView(){
        myTableView.dataSource = self
        myTableView.delegate   = self
        myTableView.register(NoticeCell.self, forCellReuseIdentifier: "NoticeList")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeList",for: indexPath) as! NoticeCell
        
        let note = noticeArray[indexPath.row]
        cell.setupCellWith(notice: note)
        
        return cell
    }
   
   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddNotice()
        vc.note = noticeArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }*/
    

}
