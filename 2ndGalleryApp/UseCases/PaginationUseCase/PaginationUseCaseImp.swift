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
    var isLoadingInProcess: Bool = false
    var newCurrentPage: Int = 1
    var popularCurrentPage: Int = 1
    var newTotalItems: Int?
    var popularTotalItems: Int?
    
    let gateway: GalleryPaginationGateway
    let settings: Settings
    
    var collectionType: CollectionType
    var newItems = [ImageEntity]()
    var popularItems = [ImageEntity]()
    let limit = 10
    var disposeBag = DisposeBag()
    
    init(gateway: GalleryPaginationGateway, settings: Settings, collectionType: CollectionType) {
        self.gateway = gateway
        self.settings = settings
        self.collectionType = collectionType
    }
    
    func hasMorePages(items: [ImageEntity], totalItems: Int?) -> Bool {
        
        guard let totalItems = totalItems else { return true }
        
        return items.count < totalItems
        
    }
    
    func getMoreImages(collectionType: CollectionType) -> Completable {
        self.cancelLoading()
        self.isLoadingInProcess = true
        var page = 1
        if collectionType == .new {
            page = newCurrentPage
        } else {
            page = popularCurrentPage
        }
        
        return .empty()
            .andThen(self.gateway.getImages(page: page,
                                            limit: self.limit,
                                            currentCollection: collectionType))
            .do(onSuccess: { [unowned self] result in
                
                switch collectionType {
                case .new: do {
                    self.newCurrentPage += 1
                    self.newTotalItems = result.totalItems
                    self.newItems.append(contentsOf: result.data)
                    self.source.onNext(self.newItems)
                    self.isLoadingInProcess = false
                }
                case .popular: do {
                    self.popularCurrentPage += 1
                    self.popularTotalItems = result.totalItems
                    self.popularItems.append(contentsOf: result.data)
                    self.source.onNext(self.popularItems)
                    self.isLoadingInProcess = false
                }
                }
                
                
            },
            onError: { error in
                self.isLoadingInProcess = false
                print(error.localizedDescription)
            })
            .asCompletable()
    }
    
    
    func reset(collectionType: CollectionType) {
        switch collectionType {
        case .new:
            self.newItems.removeAll()
            self.newTotalItems = nil
            self.newCurrentPage = 1
        case .popular:
            self.popularItems.removeAll()
            self.popularTotalItems = nil
            self.popularCurrentPage = 1
        }

    }
    
    func cancelLoading() {
        disposeBag = DisposeBag()
    }
}
