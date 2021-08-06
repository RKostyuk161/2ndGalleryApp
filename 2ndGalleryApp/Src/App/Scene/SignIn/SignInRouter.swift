//
//  SignInRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import UIKit

class SignInRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    
    init(view: SignInViewController) {
        self.view = view
    }
    
    func openMainGallery()  {
        guard let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController() else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    func openSignUpScreen(navigationController: UINavigationController) {
        let indefier = R.storyboard.signUp.signUpViewController.identifier
        guard let vc = R.storyboard.signUp().instantiateViewController(identifier: indefier) as? SignUpViewController else { return }
        SignUpConfigurator().config(view: vc)
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
