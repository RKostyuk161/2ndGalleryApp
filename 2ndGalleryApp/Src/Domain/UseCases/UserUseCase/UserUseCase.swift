//
//  UserUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol UserUseCase {
    var source: PublishSubject<[ImageEntity]> { get }
    var userSource: PublishSubject<UserEntity> { get }

    var isLoadingInProcess: Bool { get }
    var userTotalItemsOfImages: Int { get }
    var userItems: [ImageEntity] { get }

    var imageModel: ImageEntity { get }
    
    func getUserInfo() -> Single<UserEntity>
    func getUserModel(id: String) -> Completable
    func updateUserInfo(user: UserEntity) -> Completable
    func updateUserPass(user: UpdatePasswordEntity) -> Completable
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable
    func postPhoto(photo: UploadPhoto) -> Completable
    func getUserImages(userId: Int) -> Completable
    func deleteUser() -> Completable
}
