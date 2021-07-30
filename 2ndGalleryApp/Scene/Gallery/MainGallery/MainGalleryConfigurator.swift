//
//  MainGalleryConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.06.2021.
//

import Foundation

class MainGalleryConfigurator {
    func config(view: MainGalleryViewController, currentCollection: Int, currentGalleryState: Int)  {
        guard let collectionType = CollectionType(rawValue: currentCollection) else { return }
        guard let galleryType = GalleryType(rawValue: currentGalleryState) else { return }
        let router = MainGalleryRouter(view)
        let presenter = MainGalleryPresenterImp(view: view,
                                             router: router,
                                             currentGalleryState: galleryType,
                                             collectionType: collectionType,
                                             paginationUseCase: DI.resolve(),
                                             userUseCase: DI.resolve())
        view.presenter = presenter
    }
}
