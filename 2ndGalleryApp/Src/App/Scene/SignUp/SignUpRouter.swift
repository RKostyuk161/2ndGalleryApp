//
//  SignUpRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import UIKit

class SignUpRouter: BaseRouter {
    weak var view: UIViewController!
    
    init(view: SignUpViewController) {
        self.view = view
    }
    
    func openSignInScreen(navigationController: UINavigationController) {
        SignInConfigurator.open(navCon: navigationController)
    }
    
    func openMainGallery() {
        guard let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController() else { return }
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
