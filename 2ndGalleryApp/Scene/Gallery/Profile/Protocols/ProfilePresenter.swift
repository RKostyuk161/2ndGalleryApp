//
//  ProfilePresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation

protocol ProfilePresenter {
    var useCase: UserUseCase { get }
    
    var settings: Settings { get }
    
    func routeToSettings()
    
}
