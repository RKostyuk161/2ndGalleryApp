//
//  UserUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol UserUseCase {
    var userSource: PublishSubject<UserEntity> { get }
    var userTotalItemsOfImages: Int { get }
    var userItems: [ImageEntity] { get }

    func getUserInfo() -> Single<UserEntity>
    func getUserModel(id: String) -> Completable
    func updateUserInfo(user: UserEntity) -> Completable
    func updateUserPass(user: UpdatePasswordEntity) -> Completable
    func deleteUser() -> Completable
}
