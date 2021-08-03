//
//  FullImageInfoPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.07.2021.
//

import Foundation
import Kingfisher

class FullImageInfoPresenterImp: FullImageInfoPresenter {
    weak var view: FullImageInfoView!
    var settings: Settings
    let imageModel: ImageEntity
    let userModel: UserEntity
    
    init(view: FullImageInfoViewController, imageModel: ImageEntity,
         userModel: UserEntity, settings: Settings) {
        self.view = view
        self.imageModel = imageModel
        self.userModel = userModel
        self.settings = settings
    }
    
    func setView() {
        view.setView(image: imageModel.image?.name,
                     name: imageModel.name,
                     desription: imageModel.description,
                     username: userModel.username,
                     userDate: userModel.birthday)
    }
}
