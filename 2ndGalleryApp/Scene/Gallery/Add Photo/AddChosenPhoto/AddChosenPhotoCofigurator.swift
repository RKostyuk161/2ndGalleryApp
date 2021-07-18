//
//  AddChosenPhotoCofigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddChosenPhotoConfigurator {
    func configure(view: AddChosenPhotoViewController)  {
        let router = AddChosenPhotoRouter(view: view)
        let prenseter = AddChosenPhotoPresenterImp(view: view,
                                                   router: router,
                                                   settings: DI.resolve(),
                                                   usecase: DI.resolve())
        view.presenter = prenseter
    }
    static func open(navigationController: UINavigationController, image: UIImage) {
        guard let vc = R.storyboard.addChosenPhoto().instantiateViewController(identifier: R.storyboard.addChosenPhoto.name) as? AddChosenPhotoViewController else { return }
        AddChosenPhotoConfigurator().configure(view: vc)
        navigationController.pushViewController(vc, animated: true)
    }
}
