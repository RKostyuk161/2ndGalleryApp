//
//  MainGalleryConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.06.2021.
//

import Foundation

class MainGalleryConfigurator {
    func config(view: MainGalleryViewController, currentCollection: Int)  {
        guard let collectionType = CollectionType(rawValue: currentCollection) else { return }
        let router = MainGalleryRouter(view)
        let presenter = MainGalleryPresenter(view: view,
                                             router: router,
                                             collectionType: collectionType, paginationUseCase: DI.resolve())
        view.presenter = presenter
    }
}
