//
//  LoginVC.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if emailTF.text!.isEmpty {
            alert(message: "email is Empty", title: "error")
        }else {
            LocalStorage.shared.getUserbyEmail(email: emailTF.text!) { [self] (row) in
                if row == nil {
                    alert(message: "email not registerd in DB", title: "error")
                }else {
                    let password = row![LocalStorage.shared.password]
                    if passwordTF.text!.isEmpty {
                        alert(message: "password is Empty", title: "error")
                    } else {
                        if passwordTF.text != password {
                            alert(message: "password not correct", title: "error")
                        } else {
                            let user = User(name: row![LocalStorage.shared.name],
                                            email: row![LocalStorage.shared.email],
                                            phone: row![LocalStorage.shared.phone],
                                            password: row![LocalStorage.shared.password],
                                            image: Image(withImage: UIImage(data: row![LocalStorage.shared.image])!))
                            DefaultManager.isLoggedIn = true
                            DefaultManager.currentUser = user
                            if let window = self.view.window {
                                let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBar")
                                window.rootViewController = tabBar
                            }
                        }
                    }
                }
            }
        }
    }
    
}



