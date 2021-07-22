//
//  AddChosenPhotoRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddChosenPhotoRouter {
    var view: AddChosenPhotoViewController
    
    init(view: AddChosenPhotoViewController) {
        self.view = view
    }
    
    func openUploadImage(model: ImageEntity) {
        if let nc = view.navigationController {
            FullImageInfoConfigurator.open(navigationController: nc, model: model)
        }
    }
}
