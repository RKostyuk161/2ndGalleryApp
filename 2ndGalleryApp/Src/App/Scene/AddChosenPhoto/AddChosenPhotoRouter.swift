//
//  AddChosenPhotoRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddChosenPhotoRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    
    init(view: AddChosenPhotoViewController) {
        self.view = view
    }
    
    func openProfileImage() {
        guard let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController() else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
