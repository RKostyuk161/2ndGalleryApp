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
    var isLoadingInProcess: Bool { get }
    var currentPage: Int { get }
    var totalItems: Int? { get }
    
    func hasMorePages() -> Bool
    func getMoreImages() -> Completable
    func reset()
}
