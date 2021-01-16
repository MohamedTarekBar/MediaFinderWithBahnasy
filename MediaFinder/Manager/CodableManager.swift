//
//  CodableManager.swift
//  Test
//
//  Created by MohamedTarek on 26/12/2020.
//

import UIKit

struct CodabelManager {
    
    static func encode<T:Codable> (_ type:T) -> Data? {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(type)
            return encoded
        } catch {
            print(error)
        }
        return nil
    }
    
    static func decode<T:Codable> (_ data: Data, type :T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decrypted =  try decoder.decode(type, from: data)
            return decrypted
        } catch  {
            print(error)
        }
        return nil
    }
}
