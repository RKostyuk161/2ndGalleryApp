//
//  AddChosenPhotoRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit

class AddChosenPhotoRouter {
    var view: AddChosenPhotoViewController
    
    init(view: AddChosenPhotoViewController) {
        self.view = view
    }
    
    func openProfileImage() {
        let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
