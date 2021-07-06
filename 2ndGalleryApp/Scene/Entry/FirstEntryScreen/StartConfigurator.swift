//
//  StartConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation

class StartConfigurator {
    func config(view: StartViewController) {
        let router = StartRouter(view: view)
        view.router = router
    }
}
