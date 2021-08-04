//
//  ProfileCOnfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class ProfileConfigurator {
    static func config(view: ProfileViewController, currentUser: UserEntity?) {
        let router = ProfileRouter(view: view)
        let presenter = ProfilePresenterImp(view: view,
                                            router: router,
                                            settings: DI.resolve(),
                                            userUseCase: DI.resolve(),
                                            imageUseCase: DI.resolve())
        
        view.presenter = presenter
    }
}
