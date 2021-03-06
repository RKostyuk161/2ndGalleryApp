//
//  AddPhotoRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddPhotoRouter {
    
    weak var view: AddPhotoViewController!
    
    
    init(view: AddPhotoViewController) {
        self.view = view
    }
    
    func onpen(image: UIImage) {
        guard let nc = view.navigationController else { return }
        AddChosenPhotoConfigurator.open(navigationController: nc, image: image)
    }
}
