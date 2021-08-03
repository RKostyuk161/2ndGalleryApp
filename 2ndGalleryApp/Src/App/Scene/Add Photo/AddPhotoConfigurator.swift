//
//  AddPhotoConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddPhotoConfigurator {
    func configure(view: AddPhotoViewController) {
        let router = AddPhotoRouter(view: view)
        view.router = router
    }
}
