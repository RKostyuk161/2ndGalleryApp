//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation
import UIKit

class MainGalleryPresenter {
    
    var view: MainGalleryViewController!
    var router: MainGalleryRouter!
    var gateway = GalleryGateway()
    var currentCollection: CollectionType
    var newImageEntityArray = [ImageEntity]()
    var paginationNumberOfPageOfNewImages = 1
    var indexPathToScrollNewCollection = IndexPath()
    var popularImageEntitiyArray = [ImageEntity]()
    var paginationNumberOfPageOfPopularImages = 1
    var indexPathToScrollPopularCollection = IndexPath()

    
    init(view: MainGalleryViewController, router: MainGalleryRouter, collectionType: CollectionType) {
        self.view = view
        self.router = router
        self.currentCollection = collectionType
    }
    
    
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        if currentCollection.rawValue == 0 {
           imageUrl = newImageEntityArray[indexPath.item] } else {
                imageUrl = popularImageEntitiyArray[indexPath.item]

            }
        
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }

    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int {
        if collectionType.rawValue == 0 {
            return newImageEntityArray.count
        } else {
            return popularImageEntitiyArray.count
        }
    }
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.view.frame.width / CGFloat(itemsPerLine)-15, height: view.view.frame.width / CGFloat(itemsPerLine)-15)
    }
    
    func getFullGalleryRequest(isNewCollection: CollectionType) {
        var currentPagination = paginationNumberOfPageOfNewImages
        if isNewCollection.rawValue == 1 {
            currentPagination = paginationNumberOfPageOfPopularImages
        }
//        gateway.getRequest(currentUrl: GalleryGateway.getUrl, numberOfPage: currentPagination, currentCollection: currentCollection) { getInfo, message in
//            switch message {
//            
//            case "200":
//                guard let allGettingInfo = getInfo,
//                      let images = allGettingInfo.data,
//                      let pages = allGettingInfo.countOfPages else {return }
//
//                if isNewCollection.rawValue == 0 {
//                    self.newImageEntityArray.append(contentsOf: images)
//                    self.paginationNumberOfPageOfNewImages += 1
//                } else {
//                    self.popularImageEntitiyArray.append(contentsOf: images)
//                    self.paginationNumberOfPageOfPopularImages += 1
//                }
//
//                self.view.galleryCollectionView.reloadData()
//            case "no connection":
//                return
//                
//            default:
//                return
//            }
//        }
    }
    
    func getNewPaginationRequest(indexPath: IndexPath)  {
        switch currentCollection {
        case .new:
            if indexPath.item == newImageEntityArray.count - 1 {
                self.getFullGalleryRequest(isNewCollection: currentCollection)
            }
        case .popular:
            if indexPath.item == popularImageEntitiyArray.count - 1 {
                self.getFullGalleryRequest(isNewCollection: currentCollection)
            }
        }

    }
    
    func prepeareForRoute() {

    }
}
