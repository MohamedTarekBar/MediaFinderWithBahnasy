//
//  LocalStorageManager.swift
//  Test
//
//  Created by MohamedTarek on 26/12/2020.
//


import UIKit
import SQLite

class LocalStorage {
    
    static var shared = LocalStorage()
    var dataBase: Connection!

    // currentUser Table
    let currentUser = Table("currentUser")
    // currentUser Rows
        let name = Expression<String>("name")
        let email = Expression<String>("email")
        let image = Expression<Data>("image")
        let phone = Expression<String>("phone")
        let address = Expression<String>("address")
        let password = Expression<String>("password")
    
    // history Table
    let userHistory = Table("userHistory")
    // history Rows
        /// email shared with 2 tables 
        let media = Expression<Data>("media")
        let id = Expression<Int>("id")

    func connectDataBase() {
        do {
          let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
          let fileUrl = documentDir.appendingPathComponent("users").appendingPathExtension("sqlite3")
          let dataBasePath = try Connection(fileUrl.path)
            LocalStorage.shared.dataBase = dataBasePath
        }
        catch {
            print(error)
        }
    }
    
    
    func tableCreated (table: Table) -> Bool {
        let userTable = try? self.dataBase.scalar(table.exists)
        if userTable == nil {
            return true
        }
        return false
    }

}
