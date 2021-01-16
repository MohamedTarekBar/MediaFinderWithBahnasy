//
//  alert+uiviewController.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

extension UIViewController {
    func alert(message:String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
