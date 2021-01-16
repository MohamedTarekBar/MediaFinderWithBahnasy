//
//  File.swift
//  Test
//
//  Created by MohamedTarek on 26/12/2020.
//

import UIKit
import SQLite


// this page User History
extension LocalStorage {

    func setupUserHistoryColumns() {
        let columns = self.userHistory.create {
            (table) in
            table.column(id,primaryKey: true)
            table.column(email)
            table.column(media ,unique: true)
        }
          do {
            try dataBase.run(columns)
          } catch {
            print(error)
          }
    }
    
    func insertMedia(email: String, media: Media) {
        
        guard let mediaToData = CodabelManager.encode(media) else {return}
        
        let media = self.userHistory.insert (
            self.id <- id,
            self.email <- email,
            self.media <- mediaToData
        )
        do {
            try self.dataBase.run(media)
        }
        catch{
            print(error)
        }
    }
    
    func getArrOfMedia(email :String) -> [Media]? {
        var arrOfMedia:[Media] = []
        do {
            let history = try self.dataBase.prepare(self.userHistory)
            for row in history {
                let historyEmail = try row.get(self.email)
                if historyEmail == email {
                    let mediaColumn = row[LocalStorage.shared.media]
                    if let media = CodabelManager.decode(mediaColumn,type: Media.self) {
                        arrOfMedia.append(media)
                    }
                }
            }
        } catch {
            print(error)
        }
        return arrOfMedia
    }
    
    func ARCLocalStorage(email :String) -> [[Int:String]] {
        var arr:[[Int:String]] = []
        do {
            let history = try self.dataBase.prepare(self.userHistory)
            for row in history {
                let historyEmail = try row.get(self.email)
                if historyEmail == email {
                    let mediaColumn = row[LocalStorage.shared.media]
                    if let media = CodabelManager.decode(mediaColumn,type: Media.self) {
                        arr.append([row[LocalStorage.shared.id]:media.previewUrl!])
                    }
                }
            }
        } catch {
            print(error)
        }
        return arr
    }
    
    func removeExcess() {
        let arr = ARCLocalStorage(email: "m@y.com")
        for elem in arr {
            print(elem)
        }
    }
}
