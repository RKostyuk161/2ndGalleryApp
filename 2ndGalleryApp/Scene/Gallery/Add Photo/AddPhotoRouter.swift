//
//  AddPhotoRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation

class AddPhotoRouter {
    var view: AddPhotoViewController!
    
    init(view: AddPhotoViewController) {
        self.view = view
    }
    
    func onpen() {
        guard let nc = view.navigationController,
              let image = view.imagePerview.image else { return }
    
        AddChosenPhotoConfigurator.open(navigationController: nc, image: image)
    }
}
