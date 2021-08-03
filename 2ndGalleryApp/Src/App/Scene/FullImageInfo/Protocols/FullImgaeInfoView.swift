//
//  FullImgaeInfoView.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation

protocol FullImageInfoView: BaseView {
    func setView(image: String?,
                 name: String?,
                 desription: String?,
                 username: String?,
                 userDate: String?)
}
