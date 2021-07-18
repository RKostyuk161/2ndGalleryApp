//
//  AddChosenPhotoPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation

class AddChosenPhotoPresenterImp: AddChosenPhotoPresenter {
    var view: AddChosenPhotoViewController
    var router: AddChosenPhotoRouter
    var settings: Settings
    var usecase: AddPhotoUseCase
    
    init(view: AddChosenPhotoViewController,
         router: AddChosenPhotoRouter,
         settings: Settings,
         usecase: AddPhotoUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.usecase = usecase
    }
    
    func addPhoto() {
        
    }
}
