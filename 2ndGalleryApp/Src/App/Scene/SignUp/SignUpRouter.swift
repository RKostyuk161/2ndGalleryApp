//
//  SignUpRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import UIKit

class SignUpRouter {
    func openSignInScreen(navigationController: UINavigationController) {
        SignInConfigurator.open(navCon: navigationController)
    }
    
    func openMainGallery() {
        let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
