//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 07.07.2021.
//

import Foundation
import UIKit

protocol MainGalleryPresenter {
    
    var currentCollection: CollectionType { get set }
    
    func getMoreImages(collectionType: CollectionType, indexPath: IndexPath)
    
    func subscribeOnGalleryRequestResult()
    
    func prepeareForRoute(indexPath: IndexPath)
    
    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int
    
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize
}
