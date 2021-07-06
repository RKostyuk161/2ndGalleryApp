//
//  StartRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import UIKit

class StartRouter {
    weak var view: UIViewController!
    
    init(view: StartViewController) {
        self.view = view
    }
    
    func openSignUpScene() {
        if self.view.navigationController != nil {
            let vc = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
            view.navigationController?.pushViewController(vc, animated: true)
            view.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func openSingInScene() {
        if self.view.navigationController != nil {
            let vc = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(identifier: "SignInViewController") as! SignInViewController
            view.navigationController?.pushViewController(vc, animated: true)
            view.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
