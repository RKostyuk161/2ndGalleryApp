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
    
    func getUserModel(id: String) -> Single<UserEntity>
    
    func deleteUser(id: Int) -> Single<DeleteUserEntity>
}
