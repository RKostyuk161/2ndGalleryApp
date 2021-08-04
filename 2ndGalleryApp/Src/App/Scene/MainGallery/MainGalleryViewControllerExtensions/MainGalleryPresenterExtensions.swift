//
//  MainGalleryPresenterExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.08.2021.
//

import Foundation
import UIKit

extension MainGalleryPresenterImp {

    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int {
            switch currentCollection {
            case .new:
                return newImageEntityArray.count
            case .popular:
                return popularImageEntityArray.count
            }
    }
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize {
        return view.getCGSizeForGalleryCell(itemsPerLine: itemsPerLine)
    }
}
