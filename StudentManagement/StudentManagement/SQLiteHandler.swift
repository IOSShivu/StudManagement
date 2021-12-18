//
//  SQLiteHandler.swift
//  StudentManagement
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteHandler
{
    static let shared = SQLiteHandler()
    
    let dbpath = "Student.sqlite"
    var db : OpaquePointer?
    private init()
    {
        db = openDataBase()
        createTable()
        createTableNote()
    }
    func openDataBase() -> OpaquePointer?
    {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbpath)
        
        var database:OpaquePointer! = nil
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK
        {
            print("Opend Connection to db Succesfull at: \(fileURL)")
            return database
        }
        else
        {
            print("Error connecting to db")
            return nil
        }
    }
    func createTable()
    {
        let cts = """
        CREATE TABLE IF NOT EXISTS stud1(
        spid Integer PRIMARY KEY  ,
        name Text,
        address Text,
        class Text,
        password Text,
        gender Text
        );
        """
        
        var createTableStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, cts, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Table Created")
            }
            else
            {
                print("Table is not created")
            }
        }
        else
        {
            print("Statemnt not prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    func createTableNote()
    {
        let cts = """
        CREATE TABLE IF NOT EXISTS notice1(
        id Integer PRIMARY KEY autoincrement,
        title Text,
        description Text
        );
        """
        
        var createTableStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, cts, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Table Notice Created")
            }
            else
            {
                print("Table Notice is not created")
            }
        }
        else
        {
            print("Statemnt not prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(stud:Student, completion: @escaping ((Bool)-> Void)){
        let insertStatementString = "INSERT INTO stud1 (spid,name,address,class,password,gender) VALUES (?,?,?,?,?,?);"
        
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
            {
                sqlite3_bind_int(insertStatement, 1, Int32(stud.spid))
              sqlite3_bind_text(insertStatement, 2, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (stud.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (stud.cls as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (stud.pwd as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 6, (stud.gender as NSString).utf8String, -1, nil)
             if sqlite3_step(insertStatement) == SQLITE_OK{
                print("insert row successfully")
                completion(true)
            }
            else
            {
                print("could not insert row")
                completion(false)
            }
        }
        else
        {
            print("insert statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(insertStatement)
    }
    
    func fetch() -> [Student]
    {
        let fetchstring = "Select * from stud1"
        var fetchst:OpaquePointer? = nil
        var stud = [Student]()
        if sqlite3_prepare_v2(db, fetchstring, -1, &fetchst, nil) == SQLITE_OK{
            while sqlite3_step(fetchst) == SQLITE_ROW{
                print("Fetch Row succesufully")
                let spid = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 1))
                let address = String(cString: sqlite3_column_text(fetchst, 2))
                let cls = String(cString: sqlite3_column_text(fetchst, 3))
                let pwd = String(cString: sqlite3_column_text(fetchst, 4))
                let gender = String(cString: sqlite3_column_text(fetchst, 5))
                
                stud.append(Student(id: spid, name: name, address: address, cls: cls,pwd: pwd, gender: gender))
                print("\(name)")
                
            }
        }
        else
        {
            print("Select statement is not prepared")
        }
        sqlite3_finalize(fetchst)
        return stud
    }

    func delete(for id:Int, completion: @escaping ((Bool)-> Void)){
        let deleteStatementString = "delete from stud1 where spid=?;"
        
        var deleteStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
           
            if sqlite3_step(deleteStatement) == SQLITE_OK{
                print("delete row successfully")
                completion(true)
            }
            else
            {
                print("could not delete row")
                completion(false)
            }
        }
        else
        {
            print("delete statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(deleteStatement)
    }
    func update(stud:Student, completion: @escaping ((Bool)-> Void)){
        let updateStatementString = "update stud1 set name= ?,address = ?,class = ?,password = ?,gender = ? where spid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK
        {
           
            sqlite3_bind_text(updateStatement, 1, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (stud.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (stud.cls as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (stud.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (stud.gender as NSString).utf8String, -1, nil)
             sqlite3_bind_int(updateStatement, 6, Int32(stud.spid))
            if sqlite3_step(updateStatement) == SQLITE_OK{
                print("Update row successfully")
                completion(true)
            }
            else
            {
                print("could not Update row")
                completion(false)
            }
        }
        else
        {
            print("Update statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(updateStatement)
    }
    
    func insertNotice(note:Notice, completion: @escaping ((Bool)-> Void)){
        let insertStatementString = "insert into notice1(title,description) values (?,?);"
        
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(insertStatement, 1, (note.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (note.desc as NSString).utf8String, -1, nil)
           
        
            if sqlite3_step(insertStatement) == SQLITE_OK{
                print("insert row successfully")
                completion(true)
            }
            else
            {
                print("could not insert row")
                completion(false)
            }
        }
        else
        {
            print("insert statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(insertStatement)
    }
    func fetchNotice() -> [Notice]
    {
        let fetchstring = "Select * from notice1"
        var fetchst:OpaquePointer? = nil
        var note = [Notice]()
        if sqlite3_prepare_v2(db, fetchstring, -1, &fetchst, nil) == SQLITE_OK{
            while sqlite3_step(fetchst) == SQLITE_ROW{
                print("Fetch Row succesufully")
                let id = Int(sqlite3_column_int(fetchst, 0))
                let title = String(cString: sqlite3_column_text(fetchst, 1))
                let desc = String(cString: sqlite3_column_text(fetchst, 2))
                
                
                note.append(Notice(id: id, title: title, desc: desc))
                //print("\(title)")
                
            }
        }
        else
        {
            print("Select statement is not prepared")
        }
        sqlite3_finalize(fetchst)
        return note
    }
    func deleteNotice(for id:Int, completion: @escaping ((Bool)-> Void)){
        let deleteStatementString = "delete from notice1 where id=?;"
        
        var deleteStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_OK{
                print("delete row successfully")
                completion(true)
            }
            else
            {
                print("could not delete row")
                completion(false)
            }
        }
        else
        {
            print("delete statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(deleteStatement)
    }
    
    func updateNotice(note:Notice, completion: @escaping ((Bool)-> Void)){
        
        let updateStatementString = "update notice1 set title= ?,description = ? where id = ?;"
        
        var updateStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK
        {
            
            sqlite3_bind_text(updateStatement, 1, (note.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (note.desc as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 3, Int32(note.id))
            if sqlite3_step(updateStatement) == SQLITE_OK{
                print("Update row successfully")
                completion(true)
            }
            else
            {
                print("could not Update row")
                completion(false)
            }
        }
        else
        {
            print("Update statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(updateStatement)
    }
   func loginstud(for id: Int)-> [Student]
    {
        var stud = [Student]()
        let selectsstring="Select * from stud1 Where spid=?"
        var selectstatement :OpaquePointer? = nil
       
        if sqlite3_prepare_v2(db, selectsstring, -1, &selectstatement, nil) == SQLITE_OK{
            sqlite3_bind_int(selectstatement, 1, Int32(id))
            if sqlite3_step(selectstatement) == SQLITE_ROW{
                let spid = Int(sqlite3_column_int(selectstatement, 0))
                let name = String(cString: sqlite3_column_text(selectstatement, 1))
                let address = String(cString: sqlite3_column_text(selectstatement, 2))
                let cls = String(cString: sqlite3_column_text(selectstatement, 3))
                let pwd = String(cString: sqlite3_column_text(selectstatement, 4))
                let gender = String(cString: sqlite3_column_text(selectstatement, 5))
                stud.append(Student(id: spid, name: name, address: address, cls: cls, pwd: pwd, gender: gender))
                
            }
           
        }
        sqlite3_finalize(selectstatement)
        return stud
    }
    func changepwd(For id:Int,For pwd:String,completion: @escaping ((Bool)-> Void))
    {
        var updatestring="Update stud1 set password=? where spid=?;"
        var updatestatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updatestring, -1, &updatestatement, nil) == SQLITE_OK
        {
             sqlite3_bind_text(updatestatement, 1, pwd, -1,nil)
             sqlite3_bind_int(updatestatement, 2, Int32(id))
           // sqlite3_bind_text(updatestatement, 1, (pwd as NSString).utf8String,-1,nil)
           
            if sqlite3_step(updatestatement) == SQLITE_OK{
                print("Change Password")
                completion(true)
            }
            else{
                print("Not change")
                completion(false)
            }
        }
        else
        {
            print("Changestatement not prepared")
            completion(false)
        }
        sqlite3_finalize(updatestatement)
    }
    
    func searchstud(for cls: String)->[Student]
    {
        var stud = [Student]()
        let selectsstring="Select * from stud1 Where class=?"
        var selectstatement :OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, selectsstring, -1, &selectstatement, nil) == SQLITE_OK{
            sqlite3_bind_text(selectstatement, 1, cls,-1,nil)
            while sqlite3_step(selectstatement) == SQLITE_ROW{
                let spid = Int(sqlite3_column_int(selectstatement, 0))
                let name = String(cString: sqlite3_column_text(selectstatement, 1))
                let address = String(cString: sqlite3_column_text(selectstatement, 2))
                let cls = String(cString: sqlite3_column_text(selectstatement, 3))
                let pwd = String(cString: sqlite3_column_text(selectstatement, 4))
                let gender = String(cString: sqlite3_column_text(selectstatement, 5))
                stud.append(Student(id: spid, name: name, address: address, cls: cls, pwd: pwd, gender: gender))
            }
        }
        sqlite3_finalize(selectstatement)
        return stud
    }
}

