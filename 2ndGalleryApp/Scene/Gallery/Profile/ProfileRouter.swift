//
//  ProfileRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation

class ProfileRouter {
    var view: ProfileViewController!
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
    func openProfileSettingsViewCOntroller() {
        if let navController = self.view.navigationController {
            ProfileSettingsConfigurator.open(navigationController: navController)
        }
    }
}
