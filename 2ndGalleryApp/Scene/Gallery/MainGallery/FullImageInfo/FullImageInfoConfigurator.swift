//
//  FullImageInfoConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import Foundation
import UIKit

class FullImageInfoConfigurator {
    
    func configure(view: FullImageInfoViewController, model: ImageEntity) {
        let presenter = FullImageInfoPresenterImp(view: view, model: model)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController, model: ImageEntity) {
        guard let view = R.storyboard.fullImageInfo().instantiateViewController(identifier: R.storyboard.fullImageInfo.name) as? FullImageInfoViewController else { return }
//        guard let view = UIStoryboard(name: "FullImageInfo", bundle: nil)
//                .instantiateViewController(identifier: "FullImageInfoViewController") as? FullImageInfoViewController else { return }
        FullImageInfoConfigurator().configure(view: view, model: model)
        navigationController.pushViewController(view, animated: true)
        
    }
}
