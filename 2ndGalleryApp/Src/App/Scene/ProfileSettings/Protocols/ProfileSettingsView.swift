//
//  ProfileSettingsView.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation

protocol ProfileSettingsView: BaseView {
    var currentDate: String? { get set }

    func setTextFields()
    func routeUsersData() -> UserEntity
}
