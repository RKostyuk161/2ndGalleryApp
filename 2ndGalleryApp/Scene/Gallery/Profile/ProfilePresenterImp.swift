//
//  ProfilePresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation

class ProfilePresenterImp: ProfilePresenter {
    
    var view: ProfileViewController
    var router: ProfileRouter
    var settings: Settings
    
    init(view: ProfileViewController, router: ProfileRouter, settings: Settings) {
        self.view = view
        self.router = router
        self.settings = settings
    }
    
    func routeToSettings() {
        router.openProfileSettingsViewCOntroller()
    }
    
    
}
