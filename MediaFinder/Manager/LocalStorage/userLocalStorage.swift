//
//  userLocalStorage.swift
//  Test
//
//  Created by MohamedTarek on 26/12/2020.
//

import UIKit
import SQLite

enum status {
    case success
    case failure
}
// this page user
extension LocalStorage {

    func setupUserColumns() {
        let columns = self.currentUser.create {
            (table) in
            table.column(email, unique: true)
            table.column(phone)
            table.column(name)
            table.column(image)
            table.column(password)
        }
          do {
            try dataBase.run(columns)
          } catch {
            print(error)
          }
    }
    
    func insertUser(name: String,
                    email: String,
                    phone: String,
                    image: Data,
                    password:String,
                    complete : @escaping (status)->()) {
        
        let user = self.currentUser.insert(
            self.name <- name,
            self.email <- email,
            self.phone <- phone,
            self.image <- image,
            self.password <- password
        )
        do {
            try self.dataBase.run(user)
            complete(.success)
        }
        catch{
            complete(.failure)
            print(error)
        }
    }
    
    func getUserbyEmail(email :String , completion: @escaping (_ selected: Row?) -> Void) {
        var selected :Row?
        do {
            let users = try self.dataBase.prepare(self.currentUser)
            for row in users {
                let user = try row.get(self.email)
                if user == email {
                    selected = row
                    break
                }
            }
        } catch {
            print(error)
        }
        
        completion(selected)
    }
}
