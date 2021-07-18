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
    var indexPathToScrollNewCollection = IndexPath()
    
    var popularImageEntityArray = [ImageEntity]()
    var indexPathToScrollPopularCollection = IndexPath()
    
    var responseDisposeBag = DisposeBag()
    var paginationDisposeBag = DisposeBag()
    
    var isLoadingInProgress = false
    var isfistPopularImageRequest = true
    
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
                imageUrl = popularImageEntityArray[indexPath.item]
            
        }
        
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }

    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int {
        if collectionType.rawValue == 0 {
            return newImageEntityArray.count
        } else {
            return popularImageEntityArray.count
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
                
                switch self.currentCollection {
                case .new: do {
//                    guard let data = reult else { return }
                    self.newImageEntityArray = reult
                    self.view.galleryCollectionView.reloadData()
                }
                case .popular: do {
//                    guard let data = reult.data else { return }
                    self.popularImageEntityArray = reult
                    self.view.galleryCollectionView.reloadData()
                }
                }
            })
            .disposed(by: paginationDisposeBag)
    }
    
    func getFullGalleryRequest(isNewCollection: CollectionType) {
        if isNewCollection == .popular {
            isfistPopularImageRequest = false
        }
        if !isLoadingInProgress {
            isLoadingInProgress = true
            self.paginationUseCase.getMoreImages(collectionType: isNewCollection)
                .observeOn(MainScheduler.instance)
                .do(onDispose: {
                    self.view.galleryCollectionView.reloadData()
                    self.isLoadingInProgress = false
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    Alerts().addAlert(alertTitle: "Error",
                                      alertMessage: error.localizedDescription,
                                      buttonMessage: "OK",
                                      view: self.view)
                })
                .disposed(by: self.responseDisposeBag)
        }

    }
    
    func getMoreImages(collectionType: CollectionType, indexPath: IndexPath) {
        switch currentCollection {
        case .new:
            if indexPath.item == newImageEntityArray.count - 1 {
                self.getFullGalleryRequest(isNewCollection: currentCollection)
            }
        case .popular:
            if indexPath.item == popularImageEntityArray.count - 1 {
                self.getFullGalleryRequest(isNewCollection: currentCollection)
            }
        }
    }
    
    func prepeareForRoute(indexPath: IndexPath) {
        
        
        let model: ImageEntity
        switch currentCollection {
        case .new:
            model = newImageEntityArray[indexPath.item]
        case .popular:
            model = popularImageEntityArray[indexPath.item]

        }
        
        guard let nav = view.navigationController else { return }
        router.openFuillImageController(navigationController: nav, model: model)
    }
    
}
