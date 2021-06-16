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
    var model = [ImageEntity]()
    var router: Int
    var gateway = UserGateway()
    var paginationNumberOfPage = 1
    let currentCollection: CollectionType
    
    init(view: MainGalleryViewController, router: Int, collectionType: CollectionType) {
        self.view = view
        self.router = router
        self.currentCollection = collectionType
    }
    
    
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        let imageUrl = model[indexPath.item]
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }
    
    func setupNumberOfCellsForMainGalleryCollectionView() -> Int {
        return model.count}

    func setupSizeForCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.view.frame.width / CGFloat(itemsPerLine), height: view.view.frame.height / CGFloat(itemsPerLine))
    }
    
    func getFullGalleryRequest() {
        gateway.getRequest(currentUrl: UserGateway.getUrl, numberOfPage: paginationNumberOfPage, currentCollection: currentCollection) { getInfo, message in
            switch message {
            
            case "200":
                guard let allGettingInfo = getInfo,
                      let images = allGettingInfo.data,
                      let pages = allGettingInfo.countOfPages else {return }
//                if self.view.collectionViewRefreshControl.isRefreshing {
//                    self.imageArray.removeAll()
//                    self.view.collectionViewRefreshControl.endRefreshing()
//                }
//                self.view.imageCollectionView.backgroundView = nil
//                self.countOfPages = pages
                self.model.append(contentsOf: images)
                self.paginationNumberOfPage += 1
                self.view.galleryCollectionView.reloadData()
                
            case "no connection":
                return
                
            default:
                return
            }
        }
    }
//
//    func prepeareForRoute() {
//
//    }
}
