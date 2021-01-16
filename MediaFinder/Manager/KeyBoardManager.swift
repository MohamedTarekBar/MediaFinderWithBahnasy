//
//  KeyBoardManager.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

extension UIViewController {
    func hideKeyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }

    @objc func handleTap() {
        view.endEditing(true)
    }
}
