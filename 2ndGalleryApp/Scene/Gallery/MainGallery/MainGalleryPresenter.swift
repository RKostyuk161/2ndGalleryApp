//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 07.07.2021.
//

import Foundation

protocol MainGalleryPresenter {
    
    func getMoreImages(collectionType: CollectionType, page: Int)
    
    func pushFullImageInfo(indexPath: IndexPath)
    
}
