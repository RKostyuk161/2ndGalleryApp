//
//  UserGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol UserGateway {
    
    func getAcc() -> Single<UserEntity>

    func updateUserInfo(userId: Int, user: UserApiEntity) -> Single<UserEntity>
}
