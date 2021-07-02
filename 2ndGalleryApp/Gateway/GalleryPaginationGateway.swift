//
//  GalleryPaginationGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.07.2021.
//

import Foundation
import RxSwift

protocol GalleryPaginationGateway {
    func getImages(page: Int,
                   limit: Int,
                   currentCollection: CollectionType) -> Single<PaginationEntity<ImageEntities>>
}
