
import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let window = self.view.window {
            if DefaultManager.isLoggedIn {
                let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBar")
                window.rootViewController = tabBar
            } else {
                let tabBar = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "TabBar")
                window.rootViewController = tabBar
            }
        }
    }
}
