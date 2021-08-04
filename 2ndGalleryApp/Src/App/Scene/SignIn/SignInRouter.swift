//
//  SignInRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import UIKit

class SignInRouter: BaseRouter {
    
    var view: UIViewController!
    
    init(view: SignInViewController) {
        self.view = view
    }
    
    func openMainGallery()  {
        let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    func openSignUpScreen(navigationController: UINavigationController) {
        let indefier = R.storyboard.signUp.signUpViewController.identifier
        let vc = R.storyboard.signUp().instantiateViewController(identifier: indefier)
        SignUpConfigurator().config(view: vc as! SignUpViewController)
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
