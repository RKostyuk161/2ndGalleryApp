//
//  ProfileCOnfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation

class ProfileConfigurator {
    static func config(view: ProfileViewController) {
        let router = ProfileRouter(view: view)
        let presenter = ProfilePresenterImp(view: view, router: router, settings: DI.resolve())
        
        view.presenter = presenter
    }
}
