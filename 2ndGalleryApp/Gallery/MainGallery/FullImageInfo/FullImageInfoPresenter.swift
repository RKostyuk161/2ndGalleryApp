//
//  FullImageInfoPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.06.2021.
//

import Foundation
import UIKit

class FullImageInfoPresenter {
    
    weak var view: FullImageInfoViewController!
    let model: ImageEntity
    let image: UIImage
    
    init(view: FullImageInfoViewController, model: ImageEntity, image: UIImage) {
        self.view = view
        self.model = model
        self.image = image
    }
    
}
