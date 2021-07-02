//
//  FullImageInfoConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import Foundation
import UIKit

class FullImageInfoConfigurator {
    
    func configure(view: FullImageInfoViewController, model: ImageEntity, image: UIImage) {
        let presenter = FullImageInfoPresenter(view: view, model: model, image: image)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController, model: ImageEntity, image: UIImage) {
        guard let view = UIStoryboard(name: "FullImageInfo", bundle: nil)
                .instantiateViewController(identifier: "FullImageInfoViewController") as? FullImageInfoViewController else { return }
        FullImageInfoConfigurator().configure(view: view, model: model, image: image)
        navigationController.pushViewController(view, animated: true)
        
    }
}
