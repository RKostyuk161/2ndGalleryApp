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
    let model: ImageEntity
    
    init(view: FullImageInfoViewController, model: ImageEntity) {
        self.view = view
        self.model = model
    }
    
    func setView() {
        setImage(name: model.image?.name)
        setImageDescription(description: model.description)
        setImageName(imageName: model.name)
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
}
