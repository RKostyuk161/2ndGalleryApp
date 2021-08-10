//
//  AddChosenPhotoCofigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddChosenPhotoConfigurator {
   
    func configure(view: AddChosenPhotoViewController, image: UIImage)  {
        let router = AddChosenPhotoRouter(view: view)
        let prenseter = AddChosenPhotoPresenterImp(view: view,
                                                   router: router,
                                                   image: image,
                                                   settings: DI.resolve(),
                                                   userUseCase: DI.resolve(),
                                                   imageUseCase: DI.resolve())
        view.presenter = prenseter
    }
    static func open(navigationController: UINavigationController, image: UIImage) {
        MainGalleryViewController.isNeedFlipToProfile = true
        guard let vc = R.storyboard.addChosenPhoto().instantiateViewController(withIdentifier: R.storyboard.addChosenPhoto.name) as? AddChosenPhotoViewController else { return }
        AddChosenPhotoConfigurator().configure(view: vc, image: image)
        navigationController.pushViewController(vc, animated: true)
    }
}
