//
//  ProfileSettingsRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileSettingsRouter: BaseRouter {
    
    var view: UIViewController!
    
    
    init(view: ProfileSettingsViewController) {
        self.view = view
    }
    
    func routeToProfile(currentUser: UserEntity) {
        guard let navigationController = getNavigationController() else { return }
        navigationController.popViewController(animated: true)
        ProfileConfigurator.config(view: ProfileViewController(), currentUser: currentUser)
    }
    
    func routeToStartView() {
        guard let mainTabBar = R.storyboard.main.instantiateInitialViewController() else { return }
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
