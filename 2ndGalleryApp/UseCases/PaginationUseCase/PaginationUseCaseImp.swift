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
    var currentPage: Int = 1
    var totalItems: Int?
    
    let gateway: GalleryPaginationGateway
    let settings: Settings
    var collectionType: CollectionType
    var items = [ImageEntity]()
    let limit = 10
    var disposeBag = DisposeBag()
    
    init(gateway: GalleryPaginationGateway, settings: Settings, collectionType: CollectionType) {
        self.gateway = gateway
        self.settings = settings
        self.collectionType = collectionType
    }
    
    func hasMorePages() -> Bool {
        
        guard let totalItems = self.totalItems else { return true }
        
        return self.items.count < totalItems
        
    }
    
    func getMoreImages() -> Completable {
        self.cancelLoading()
        self.isLoadingInProcess = true
        return .empty()
            .andThen(self.gateway.getImages(page: self.currentPage,
                                            limit: self.limit,
                                            currentCollection: collectionType))
            .do(onSuccess: { [unowned self] result in
                self.currentPage += 1
                self.totalItems = result.totalItems
                self.items.append(contentsOf: self.items)
                self.source.onNext(self.items)
                self.isLoadingInProcess = false
            },
            onError: { error in
                self.isLoadingInProcess = false
                print(error.localizedDescription)
            })
            .asCompletable()

                
    }
    
    func reset() {
        self.items.removeAll()
        self.totalItems = nil
        self.currentPage = 1
    }
    
    func cancelLoading() {
        disposeBag = DisposeBag()
    }
}
