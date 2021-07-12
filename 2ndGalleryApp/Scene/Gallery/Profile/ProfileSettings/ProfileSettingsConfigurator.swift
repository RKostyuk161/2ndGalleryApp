//
//  ProfileSettingsConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileSettingsConfigurator {
    
    func config(view: ProfileSettingsViewController) {
        let router = ProfileSettingsRouter()
        let presenter = ProfileSettingsPresenterImp(view: view,
                                                    router: router,
                                                    settings: DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        guard let vc = R.storyboard.profileSettings().instantiateViewController(withIdentifier: R.storyboard.profileSettings.name) as? ProfileSettingsViewController else { return }
        ProfileSettingsConfigurator().config(view: vc)
        navigationController.pushViewController(vc, animated: true)
        
    }
}
