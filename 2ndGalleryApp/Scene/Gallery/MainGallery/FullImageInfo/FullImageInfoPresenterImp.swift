//
//  FullImageInfoPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.07.2021.
//

import Foundation
import Kingfisher

class FullImageInfoPresenterImp: FullImageInfoPresenter {
    weak var view: FullImageInfoViewController!
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
        setImage(name: imageModel.image?.name)
        setImageDescription(description: imageModel.description)
        setImageName(imageName: imageModel.name)
        setUserFields()
    }
    
    func setImage(name: String?) {
        guard let name = name else { return }
        let url = URL(string: "http://gallery.dev.webant.ru/media/\(name)")
        view.image.kf.indicatorType = .activity
        view.image.kf.setImage(with: url)
    }
    
    func setImageDescription(description: String?) {
        guard let desc = description else { return }
        view.descriptoinLabel.text = desc
    }
    
    func setImageName(imageName: String?) {
        guard let imageName = imageName else { return }
        view.nameLabel.text = imageName
    }

    func setUserFields() {
        view.userNameLabel.text = settings.account?.username ?? "no data"
        view.birthDayUserNameLabel.text = settings.account?.birthday ?? "no data"
    }
}
