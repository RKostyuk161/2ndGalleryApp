//
//  FullImageInfoConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import Foundation
import UIKit

class FullImageInfoConfigurator {
    
    func configure(view: FullImageInfoViewController, imageModel: ImageEntity, userModel: UserEntity) {
        let presenter = FullImageInfoPresenterImp(view: view, imageModel: imageModel, userModel: userModel, settings: DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController,
                     imageModel: ImageEntity,
                     userModel: UserEntity) {
        guard let view = R.storyboard.fullImageInfo().instantiateViewController(withIdentifier: R.storyboard.fullImageInfo.name) as? FullImageInfoViewController else { return }
        FullImageInfoConfigurator().configure(view: view, imageModel: imageModel, userModel: userModel)
        navigationController.pushViewController(view, animated: true)
        
    }
}
