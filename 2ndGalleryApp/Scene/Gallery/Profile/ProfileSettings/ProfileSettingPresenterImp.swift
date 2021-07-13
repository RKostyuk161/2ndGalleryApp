//
//  ProfileSettingPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileSettingsPresenterImp: ProfileSettingsPresenter {
    
    var view: ProfileSettingsViewController
    var router: ProfileSettingsRouter
    var settings: Settings
    
    init(view: ProfileSettingsViewController,
         router: ProfileSettingsRouter,
         settings: Settings) {
        self.view = view
        self.router = router
        self.settings = settings
    }
    
    func saveSettings() {
        
    }
    
    func updatePhoto(image: UIImage) {
        
    }
    
}
