//
//  StartConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import UIKit

class StartConfigurator {
   
    func config(view: StartViewController) {
        let router = StartRouter(view: view)
        view.router = router
    }
    
    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.main.startViewController() else { return }
        StartConfigurator().config(view: view)
        view.navigationController?.setToolbarHidden(true, animated: false)
        navigationController.pushViewController(view, animated: true)
    }
}
