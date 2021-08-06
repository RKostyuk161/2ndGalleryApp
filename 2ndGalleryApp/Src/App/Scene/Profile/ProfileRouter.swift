//
//  ProfileRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
    func openProfileSettingsViewCOntroller(currentUser: UserEntity?) {
        if let navController = self.view.navigationController {
            ProfileSettingsConfigurator.open(navigationController: navController, currentUser: currentUser)
        }
    }
}
