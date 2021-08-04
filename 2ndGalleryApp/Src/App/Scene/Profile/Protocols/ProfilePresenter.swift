//
//  ProfilePresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

protocol ProfilePresenter {
    var userUseCase: UserUseCase { get }
    var userPhotoItems: [ImageEntity] { get }
    var settings: Settings { get }
    
    func subscribeOnUserImages()
    func routeToSettings()
    func getCurrentUserImages()
    func setUser()
    func getUser() -> UserEntity?
    func moveToFullImage(indexPath: IndexPath)
}
