//
//  RegisterVC.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
    }
    
    @IBAction func pushToRegister2(_ sender: Any) {
        check { [self] (user) in
            LocalStorage.shared.getUserbyEmail(email: emailTF.text!) { (row) in
                if row == nil {
                    let register2 = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "Register2VC") as! Register2VC
                    register2.user = user
                    self.navigationController?.pushViewController(register2, animated: true)
                } else {
                    alert(message: "email exist try to login", title: "error")
                }
            }

        }
    }
    
    func check(complete: @escaping (User)->()) {
        
        let name = nameTF.text?.isValid(.name)
        let email = emailTF.text?.isValid(.email)
        let phone = phoneTF.text?.isValid(.phone)
        let password = passwordTF.text?.isValid(.password)

        guard name?.0 == true else {
            alert(message: name?.1 ?? "", title: "error")
            return
        }
        guard email?.0 == true else {
            alert(message: email?.1 ?? "", title: "error")
            return
        }
        guard phone?.0 == true else {
            alert(message: phone?.1 ?? "", title: "error")
            return
        }
        guard password?.0 == true else {
            alert(message: password?.1 ?? "", title: "error")
            return
        }
        let user = User(name: nameTF.text, email: emailTF.text, phone: phoneTF.text, password: passwordTF.text)
        complete(user)
    }
}


class Register2VC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var defaultImage: UIImage?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
        setup()
    }
    
    func setup() {
        defaultImage = imageView.image
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageButtonClicked))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func imageButtonClicked() {
        showPickerController()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard imageView.image != defaultImage  else {
            alert(message: "upload image First", title: "error")
            return
        }
        user?.image = Image(withImage: imageView.image!)
        let storage = LocalStorage.shared
        guard let user = user else {return}
        storage.insertUser(name: user.name!, email: user.email!, phone: user.phone!, image: user.image!.imageData!,password: user.password!, complete: { status in
            
            switch status {
            case .success :
                DefaultManager.currentUser = user
                DefaultManager.isLoggedIn = true
                
                if let window = self.view.window {
                    let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBar")
                    window.rootViewController = tabBar
                }
            case .failure : print("Error")
            }
        })
    }
}

extension Register2VC: UIImagePickerControllerDelegate,
                       UINavigationControllerDelegate {
    func showPickerController () {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let orignalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = orignalImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}


