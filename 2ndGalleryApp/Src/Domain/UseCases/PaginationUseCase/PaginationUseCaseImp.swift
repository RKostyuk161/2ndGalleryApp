//
//  PaginationUseCaseImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.07.2021.
//

import Foundation
import RxSwift

class PaginationUseCaseImp: PaginationUseCase {
   
    var source = PublishSubject<[ImageEntity]>()
    var search = PublishSubject<[ImageEntity]>()
    var isLoadingInProcess: Bool = false
    var newCurrentPage: Int = 1
    var popularCurrentPage: Int = 1
    var newTotalItems = 0
    var popularTotalItems = 0
    var searchItems = [ImageEntity]()
    
    let gateway: GalleryPaginationGateway
    let settings: Settings
    
    var newItems = [ImageEntity]()
    var popularItems = [ImageEntity]()
    let limit = 10
    var disposeBag = DisposeBag()
    
    init(gateway: GalleryPaginationGateway, settings: Settings) {
        self.gateway = gateway
        self.settings = settings
    }
    
    func hasMorePages(collectionType: CollectionType) -> Bool {
        
        switch collectionType {
        case .new:
            return newItems.count < newTotalItems
        default:
            return popularItems.count < popularTotalItems
        }        
    }
    
    func getMoreImages(collectionType: CollectionType) -> Completable {
        self.cancelLoading()
        self.isLoadingInProcess = true
        
        var page: Int
        
        switch collectionType {
        case .new:
            page = self.newCurrentPage
            
        case .popular:
            page = self.popularCurrentPage
        }
       
        return self.gateway.getImages(page: page,
                                            limit: self.limit,
                                            currentCollection: collectionType)
            .do(onSuccess: { [unowned self] result in
                switch collectionType {
                case .new:
                    do {
                        self.newCurrentPage += 1
                        self.newTotalItems = result.totalItems ?? 0
                        guard let data = result.data else { return }
                        self.newItems.append(contentsOf: data)
                        self.source.onNext(self.newItems)
                        self.isLoadingInProcess = false
                    }
                    
                case .popular:
                    do {
                        self.popularCurrentPage += 1
                        self.popularTotalItems = result.totalItems ?? 0
                        guard let data = result.data else { return }
                        self.popularItems.append(contentsOf: data)
                        self.source.onNext(self.popularItems)
                        self.isLoadingInProcess = false
                        print(self.source)
                    }
                }
            },
            onError: { error in
                self.isLoadingInProcess = false
                print(error.localizedDescription)
            })
            .asCompletable()
    }
    
    func searchImages(imageName: String, currentCollection: CollectionType) -> Completable {
        cancelLoading()
        return self.gateway.searchImages(imageName: imageName, currentCollection: currentCollection)
            .do(onSuccess: { [weak self] result in
                guard let self = self,
                      let data = result.data,
                      let items = result.totalItems else { return }
                if items == 0 {
                    self.searchItems.removeAll()
                    self.search.onNext(self.searchItems)

                } else {
                    self.searchItems = data
                    self.search.onNext(self.searchItems)
                }
            },
            onError: { error in
                print(error.localizedDescription)
            })
            .asCompletable()
    }
    
    func reset(currentGalleryState: GalleryType, collectionType: CollectionType) {
        switch currentGalleryState {
        case .search:
            self.searchItems.removeAll()
        default:
            switch collectionType {
            case .new:
                self.newItems.removeAll()
                self.newTotalItems = 0
                self.newCurrentPage = 1
        
            case .popular:
                self.popularItems.removeAll()
                self.popularTotalItems = 0
                self.popularCurrentPage = 1
            }
        }

    }
    
    func cancelLoading() {
        disposeBag = DisposeBag()
    }
}
