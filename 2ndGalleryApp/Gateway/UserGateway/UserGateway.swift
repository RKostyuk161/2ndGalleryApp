//
//  UserGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol UserGateway {
    
    func getAcc() -> Single<UserEntity>

    func updateUserInfo(userId: Int, user: UserApiEntity) -> Single<UserEntity>
    
    func updateUserPass(userId: Int, user: UpdatePasswordEntity) -> Single<UpdatePasswordEntity>
    
    func addPhoto(addPhoto: UploadFile) -> Single<FileEntity>
    
    func uploadPhotoDetails(photo: UploadPhoto) -> Single<ImageEntity>
    
    func getUserImages(userId: Int) -> Single<ImageEntities>
    
    func deleteUser(id: Int) -> Single<DeleteUserEntity>
}
