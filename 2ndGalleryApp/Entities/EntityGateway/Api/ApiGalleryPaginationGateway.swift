//
//  ApiGalleryPaginationGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiGalleryPaginationGateway: ApiBaseGateway, GalleryPaginationGateway {
    
    func getImages(page: Int,
                   limit: Int,
                   currentCollection: CollectionType) -> Single<PaginationEntity<[ImageEntity]>> {
        return apiClient.execute(request: ExtendedApiRequest.getGalleryRequest(page: page,
                                                                               limit: limit,
                                                                               currentCollection: currentCollection))
    }
    
}
