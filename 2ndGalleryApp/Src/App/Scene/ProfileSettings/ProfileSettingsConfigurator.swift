//
//  ProfileSettingsConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileSettingsConfigurator {
    
    func config(view: ProfileSettingsViewController, currentUser: UserEntity) {
        let router = ProfileSettingsRouter()
        let presenter = ProfileSettingsPresenterImp(view: view,
                                                    router: router,
                                                    settings: DI.resolve(),
                                                    userUseCase: DI.resolve(),
                                                    currentUser: currentUser)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController, currentUser: UserEntity?) {
        guard let vc = R.storyboard.profileSettings().instantiateViewController(withIdentifier: R.storyboard.profileSettings.name) as? ProfileSettingsViewController else { return }
        guard let user = currentUser else { return }
        ProfileSettingsConfigurator().config(view: vc, currentUser: user)
        navigationController.pushViewController(vc, animated: true)
        
    }
}
