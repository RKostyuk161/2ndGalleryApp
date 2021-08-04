//
//  ImagesGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol ImagesGateway {
    
    func addPhoto(addPhoto: UploadFile) -> Single<FileEntity>
    
    func uploadPhotoDetails(photo: UploadPhoto) -> Single<ImageEntity>

    func getUserImages(userId: Int) -> Single<ImageEntities>
}

