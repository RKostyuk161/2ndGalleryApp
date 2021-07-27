//
//  SignInRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import UIKit

class SignInRouter {
    func openMainGallery()  {
        let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    func openSignUpScreen(navigationController: UINavigationController) {
        let indefier = R.storyboard.signUp.signUpViewController.identifier
        let vc = R.storyboard.signUp().instantiateViewController(identifier: indefier)
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
