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
    var currentGalleryState: GalleryType
    
    var newImageEntityArray = [ImageEntity]()
    var indexPathToScrollNewCollection = IndexPath()
    
    var popularImageEntityArray = [ImageEntity]()
    var indexPathToScrollPopularCollection = IndexPath()
    
    var searchItemsEntityArray = [ImageEntity]()
    
    var responseDisposeBag = DisposeBag()
    var paginationDisposeBag = DisposeBag()
    var searchDisposeBag = DisposeBag()
    
    var isLoadingInProgress = false
    var isfistPopularImageRequest = true
    
    init(view: MainGalleryViewController,
         router: MainGalleryRouter,
         currentGalleryState: GalleryType,
         collectionType: CollectionType,
         paginationUseCase: PaginationUseCase) {
        self.view = view
        self.router = router
        self.currentGalleryState = currentGalleryState
        self.currentCollection = collectionType
        self.paginationUseCase = paginationUseCase
    }
   
    func subscribeOnGalleryRequestResult() {
        paginationUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (reult: [ImageEntity]) in
                guard let self = self else { return }
                
                switch self.currentCollection {
                case .new: do {
                    self.newImageEntityArray = reult
                    self.view.galleryCollectionView.reloadData()
                }
                case .popular: do {
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
                    self.view.collectionViewRefreshControl.endRefreshing()
                    self.view.galleryCollectionView.reloadData()
                    self.isLoadingInProgress = false
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    Alerts().addAlert(alertTitle: "Gallery Error",
                                      alertMessage: error.localizedDescription,
                                      buttonMessage: "OK",
                                      view: self.view)
                })
                .disposed(by: self.responseDisposeBag)
        }

    }
    
    func getMoreImages(collectionType: CollectionType, indexPath: IndexPath) {
        view.isLastPaginationPage = false
        if paginationUseCase.hasMorePages(collectionType: collectionType) {
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
        } else {
            view.isLastPaginationPage = true
            return
        }
    }
    
    func subscribeOnSearch() {
        paginationUseCase.search
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (reult: [ImageEntity]) in
            guard let self = self else { return }
                self.searchItemsEntityArray.removeAll()

                self.searchItemsEntityArray = reult
                if self.searchItemsEntityArray.isEmpty {
                    self.view.showErrorOnGallery(show: true)
                } else {
                    self.view.showErrorOnGallery(show: false)
                }
                self.view.galleryCollectionView.reloadData()
            })
        .disposed(by: paginationDisposeBag)
    }
    
    func getSearchImagesRequest(imageName: String, currentCollection: CollectionType) {
        view.isLastPaginationPage = true
        paginationUseCase.searchImages(imageName: imageName,
                                       currentCollection: currentCollection)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            }, onDispose: {
                self.view.presentedViewController?.dismiss(animated: true, completion: nil)
            })
            .subscribe(onError: {
                [weak self] error in
                guard let self = self else { return }
                
                Alerts().addAlert(alertTitle: "Gallery Error",
                                  alertMessage: error.localizedDescription,
                                  buttonMessage: "OK",
                                  view: self.view)
            })
            .disposed(by: responseDisposeBag)
    }
    
    func gallerySegmentControlAction() {
        if view.gallerySegmentControl.selectedSegmentIndex == 0 {
            view.gallerySegmentControl.changeUnderlinePosition()
            currentCollection = .new
            view.galleryCollectionView.reloadData()
            if let currentpos = view.positionOfNewGallery {
                view.galleryCollectionView.scrollToItem(at: currentpos, at: .bottom, animated: false)
            }
        } else {
            view.gallerySegmentControl.changeUnderlinePosition()
            currentCollection = .popular
            if isfistPopularImageRequest {
                getFullGalleryRequest(isNewCollection: currentCollection)
            }
            view.galleryCollectionView.reloadData()
            if let currentpos = view.positionOfPopularGallery {
                view.galleryCollectionView.scrollToItem(at: currentpos, at: .centeredHorizontally, animated: false)
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
    
    func refresh() {
        paginationUseCase.reset(currentGalleryState: currentGalleryState, collectionType: self.currentCollection)
    }
}
