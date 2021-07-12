//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation
import RxSwift

class MainGalleryPresenterImp: MainGalleryPresenter {

    var view: MainGalleryViewController!
    var router: MainGalleryRouter!
    var paginationUseCase: PaginationUseCase
    var currentCollection: CollectionType
    
    var newImageEntityArray = [ImageEntity]()
    var paginationNumberOfPageOfNewImages = 1
    var indexPathToScrollNewCollection = IndexPath()
    
    var popularImageEntitiyArray = [ImageEntity]()
    var paginationNumberOfPageOfPopularImages = 1
    var indexPathToScrollPopularCollection = IndexPath()
    
    var responseDisposeBag = DisposeBag()
    var paginationDisposeBag = DisposeBag()

    
    init(view: MainGalleryViewController,
         router: MainGalleryRouter,
         collectionType: CollectionType,
         paginationUseCase: PaginationUseCase) {
        self.view = view
        self.router = router
        self.currentCollection = collectionType
        self.paginationUseCase = paginationUseCase
    }
    
    
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        if currentCollection.rawValue == 0 {
            imageUrl = newImageEntityArray[indexPath.item]
        } else {
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
    


    
    func subscribeOnGalleryRequestResult() {
        paginationUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (reult: [ImageEntity]) in
                guard let self = self else { return }
                
                if self.currentCollection.rawValue == 0 {
                    self.newImageEntityArray.append(contentsOf: reult)
                    self.view.galleryCollectionView.reloadData()
                } else {
                    self.popularImageEntitiyArray.append(contentsOf: reult)
                    self.view.galleryCollectionView.reloadData()
                }
            })
            .disposed(by: paginationDisposeBag)
    }
    
    func getFullGalleryRequest(isNewCollection: CollectionType) {
        var currentPagination = paginationNumberOfPageOfNewImages
        if isNewCollection.rawValue == 1 {
            currentPagination = paginationNumberOfPageOfPopularImages
        }
        self.paginationUseCase.getMoreImages(collectionType: isNewCollection)
            .observeOn(MainScheduler.instance)
            .do(onDispose: {
                self.view.galleryCollectionView.reloadData()
                
            })
            .subscribe(onError: { [weak self] error in
                        guard let self = self else { return }
                
            })
            .disposed(by: self.responseDisposeBag)
    }
    
    func getMoreImages(collectionType: CollectionType, indexPath: IndexPath) {
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
    
    func prepeareForRoute(indexPath: IndexPath) {
        
    }
    
}
