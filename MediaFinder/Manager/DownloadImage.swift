//
//  File.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    func downladImage(url: URL? = nil, urlString: String? = nil) {
        if url == nil && urlString == nil {
            
        } else if url != nil {
            DispatchQueue.main.async { [self] in
                sd_setImage(with: url) { (image, error, cashe, url) in
                    self.image = image
                }
            }
        } else if urlString != nil {
            let url = URL(string: urlString!)
            DispatchQueue.main.async { [self] in
                sd_setImage(with: url) { (image, error, cashe, url) in
                    self.image = image
                }
            }
        }
    }
}
