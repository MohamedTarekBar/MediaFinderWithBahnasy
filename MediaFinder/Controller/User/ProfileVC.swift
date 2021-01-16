//
//  ProfileVC.swift
//  ToDoList
//
//  Created by MohamedTarek on 06/01/2021.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
        setup()
    }
    
    func setup() {
        let user = DefaultManager.currentUser
        profileImageView.image = user?.image?.getImage()
        nameLabel.text = user?.name
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        DefaultManager.isLoggedIn = false
        mediaPlayer.media.pauseMedia(type: .song)
        
        if let window = self.view.window {
            let tabBar = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "TabBar")
            window.rootViewController = tabBar
        }
    }
}
