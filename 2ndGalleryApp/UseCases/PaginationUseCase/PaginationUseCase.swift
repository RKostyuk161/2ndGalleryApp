//
//  PaginationUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.07.2021.
//

import Foundation
import RxSwift

protocol PaginationUseCase {
    var source: PublishSubject<[ImageEntity]> { get }
    var search: PublishSubject<[ImageEntity]> { get }
    var isLoadingInProcess: Bool { get }
    
    var newCurrentPage: Int { get }
    var popularCurrentPage: Int { get }
    
    var newTotalItems: Int { get }
    var popularTotalItems: Int { get }
    
    var newItems: [ImageEntity] { get }
    var popularItems: [ImageEntity] { get }
    var searchItems: [ImageEntity] { get }
    
    func hasMorePages(items: [ImageEntity], totalItems: Int?) -> Bool
    func getMoreImages(collectionType: CollectionType) -> Completable
    func searchImages(imageName: String, currentCollection: CollectionType) -> Completable
    func reset(collectionType: CollectionType)
}
