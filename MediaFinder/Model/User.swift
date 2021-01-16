//
//  User.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

struct User :Codable {
    var name: String?
    var email: String?
    var phone:String?
    var password: String?
    var image: Image?
}

struct Image: Codable{
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
