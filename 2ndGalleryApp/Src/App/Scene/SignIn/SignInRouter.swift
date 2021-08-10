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
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    func openSignUpScreen(navigationController: UINavigationController) {
        let identifier = R.storyboard.signUp.signUpViewController.identifier
        guard let vc = R.storyboard.signUp().instantiateViewController(withIdentifier: identifier)  as? SignUpViewController else { return }
        SignUpConfigurator().config(view: vc)
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
