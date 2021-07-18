//
//  MainGalleryRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.06.2021.
//

import UIKit

class MainGalleryRouter {
    weak var view: UIViewController!
    
    
    init(_ view: MainGalleryViewController) {
        self.view = view
    }
    
    func openFuillImageController(navigationController: UINavigationController,
                                  model: ImageEntity) {
        FullImageInfoConfigurator.open(navigationController: navigationController,
                                       model: model)
    }
}
