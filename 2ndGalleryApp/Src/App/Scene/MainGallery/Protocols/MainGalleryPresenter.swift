//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 07.07.2021.
//

import Foundation
import UIKit

protocol MainGalleryPresenter {
    
    var currentGalleryState: GalleryType { get set }
    var currentCollection: CollectionType { get set }
    var newImageEntityArray: [ImageEntity] { get set }
    var popularImageEntityArray: [ImageEntity] { get set }
    var isfistPopularImageRequest: Bool { get set }
    
    func getMoreImages(collectionType: CollectionType, indexPath: IndexPath)
    
    func subscribeOnGalleryRequestResult()
    func subscribeOnSearch()
        
    func getFullGalleryRequest(isNewCollection: CollectionType)
    
    func getSearchImagesRequest(imageName: String, currentCollection: CollectionType)
    
    func prepeareForRoute(indexPath: IndexPath)
    
    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize
    
    func subscribeOnUserModel()
    
    func getUserModel(id: String)
    
    func refresh()
}
