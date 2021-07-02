//
//  UserUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol userUseCase {
    func synchronizeUserInfo() -> Single<UserEntity>
    
    func updateUserInfo(user: UserEntity, jpgData: Data?) -> Completable
    
    func updateInfoWithoutPhoto(user: UserEntity) -> Completable 
}