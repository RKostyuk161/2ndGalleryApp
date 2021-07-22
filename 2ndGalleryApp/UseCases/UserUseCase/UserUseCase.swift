//
//  UserUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol UserUseCase {
    func getUserInfo() -> Single<UserEntity>
    
    func updateUserInfo(user: UserEntity, jpgData: Data?) -> Completable
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable
    func deleteUser() -> Completable
}
