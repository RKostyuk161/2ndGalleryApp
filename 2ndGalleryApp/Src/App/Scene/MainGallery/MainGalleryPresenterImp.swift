//
//  MainGalleryPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation
import RxSwift

class MainGalleryPresenterImp: MainGalleryPresenter {    

    weak var view: MainGalleryView!
    var router: MainGalleryRouter!
    var paginationUseCase: PaginationUseCase
    var userUseCase: UserUseCase
    var currentCollection: CollectionType
    var currentGalleryState: GalleryType
    var newImageEntityArray = [ImageEntity]()
    var indexPathToScrollNewCollection = IndexPath()
    var popularImageEntityArray = [ImageEntity]()
    var indexPathToScrollPopularCollection = IndexPath()
    var responseDisposeBag = DisposeBag()
    var paginationDisposeBag = DisposeBag()
    var searchDisposeBag = DisposeBag()
    var userModel = UserEntity(user: SignUpEntity())
    var imageModel = ImageEntity()
    var isLoadingInProgress = false
    var isfistPopularImageRequest = true
   
    init(view: MainGalleryViewController,
         router: MainGalleryRouter,
         currentGalleryState: GalleryType,
         collectionType: CollectionType,
         paginationUseCase: PaginationUseCase,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.currentGalleryState = currentGalleryState
        self.currentCollection = collectionType
        self.paginationUseCase = paginationUseCase
        self.userUseCase = userUseCase
    }
   
    func subscribeOnGalleryRequestResult() {
        paginationUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (reult: [ImageEntity]) in
                guard let self = self else { return }
                
                switch self.currentCollection {
                case .new: do {
                    self.newImageEntityArray = reult
                    self.view.collectionViewReloadData()
                }
                case .popular: do {
                    self.popularImageEntityArray = reult
                    self.view.collectionViewReloadData()
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
                    self.view.collectionViewEndRefreshing()
                    self.view.collectionViewReloadData()
                    self.isLoadingInProgress = false
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                            alertMessage: error.localizedDescription,
                                            buttonMessage: R.string.alert.okMessage())
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
                switch self.currentCollection {
                case .new:
                    self.newImageEntityArray = reult
                
                case .popular:
                    self.popularImageEntityArray = reult
                }

                if reult.isEmpty {
                    self.view.showErrorOnGallery(show: true)
                } else {
                    self.view.showErrorOnGallery(show: false)
                }
                
                self.view.collectionViewReloadData()
            })
        .disposed(by: searchDisposeBag)
    }
    
    func getSearchImagesRequest(imageName: String, currentCollection: CollectionType) {
        view.isLastPaginationPage = true
        // TODO: - один метод на получение картинок
        paginationUseCase.searchImages(imageName: imageName,
                                       currentCollection: currentCollection)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                // TODO: - Почистить
                CustomActivityIndicatorConfigurator.open()
            }, onDispose: {
                self.router.dismissPresentedController()
            })
            .subscribe(onError: {
                [weak self] error in
                guard let self = self else { return }
                self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.errorMessage(),
                                                alertMessage: error.localizedDescription,
                                                buttonMessage: R.string.alert.okMessage())
            })
            .disposed(by: responseDisposeBag)
    }
    
    func subscribeOnUserModel() {
        userUseCase.userSource
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (reult: UserEntity) in
            guard let self = self else { return }
                self.userModel = reult
                self.openFullImageController()
            })
        .disposed(by: paginationDisposeBag)
    }
    
    func getUserModel(id: String) {
        userUseCase.getUserModel(id: id)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            }, onDispose: {
                self.router.dismissPresentedController()
            })
            .subscribe(onError: { [weak self] error in
                guard let self = self else { return }
                self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                        alertMessage: error.localizedDescription,
                                        buttonMessage: R.string.alert.okMessage())
            })
            .disposed(by: responseDisposeBag)
    }
    
    func routeToFullImage(indexPath: IndexPath) {

    }
    
    func prepeareForRoute(indexPath: IndexPath) {
        switch currentCollection {
        case .new:
            self.imageModel = newImageEntityArray[indexPath.item]
            guard let userId = imageModel.user else {
                openFullImageController()
                return
            }
            getUserModel(id: userId)
        case .popular:
            self.imageModel = popularImageEntityArray[indexPath.item]
            guard let userId = imageModel.user else {
                openFullImageController()
                return
            }
            getUserModel(id: userId)
        }
    }
    
    func openFullImageController() {
            // TODO: - убрать хуйню
            guard let navigationController = self.router.getNavigationController() else { return }
            self.router.openFuillImageController(navigationController: navigationController,
                                                 imageModel: self.imageModel,
                                                 userModel: self.userModel)
        
    }
    
    func refresh() {
        paginationUseCase.reset(currentGalleryState: currentGalleryState, collectionType: self.currentCollection)
    }
}
