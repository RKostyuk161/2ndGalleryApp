//
//  ApiImagesGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiImagesGateway: ApiBaseGateway, ImagesGateway {
    
    func addPhoto(addPhoto: UploadFile) -> Single<FileEntity> {
        let request: ApiRequest<FileEntity> = ExtendedApiRequest.addPhotoRequest(addPhoto: addPhoto)
        request.responseTimeout = 120
        return apiClient.execute(request: request)
    }
    
    func uploadPhotoDetails(photo: UploadPhoto) -> Single<ImageEntity> {
        let request: ApiRequest<ImageEntity> = ExtendedApiRequest.uploadPhotoRequest(photo: photo)
        return apiClient.execute(request: request)
    }
    
    func getUserImages(userId: Int) -> Single<ImageEntities> {
        let request: ApiRequest<ImageEntities> = ExtendedApiRequest.searchUsersPhotoRequest(userId: userId)
        return apiClient.execute(request: request)
    }
}
