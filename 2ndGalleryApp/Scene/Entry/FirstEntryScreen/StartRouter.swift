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
            let identifier = R.storyboard.signUp.signUpViewController.identifier
            let vc = R.storyboard.signUp().instantiateViewController(withIdentifier: identifier)
            view.navigationController?.pushViewController(vc, animated: true)
            view.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func openSingInScene() {
        if self.view.navigationController != nil {
            let identifier = R.storyboard.signIn.signInViewController.identifier
            let vc = R.storyboard.signIn().instantiateViewController(withIdentifier: identifier)
            view.navigationController?.pushViewController(vc, animated: true)
            view.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
