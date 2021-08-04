//
//  ApiUserGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiUserGateway: ApiBaseGateway, UserGateway {   
    
    
    func deleteUser(id: Int) -> Single<DeleteUserEntity> {
        return apiClient.execute(request: ExtendedApiRequest.deleteUserRequest(id: id))
    }
    
    
    func getAcc() -> Single<UserEntity> {
        return apiClient.execute(request: ExtendedApiRequest.getAccRequest())
    }
    
    func getUserModel(id: String) -> Single<UserEntity> {
        let request: ApiRequest<UserEntity> = ExtendedApiRequest.getAccModel(id: id)
        return apiClient.execute(request: request)
    }
    
    func updateUserInfo(userId: Int, user: UserApiEntity) -> Single<UserEntity> {
        let request: ApiRequest<UserEntity> = ExtendedApiRequest.updateUserUnfo(userId: userId, user: user)
        return apiClient.execute(request: request)
    }
    
    func updateUserPass(userId: Int, user: UpdatePasswordEntity) -> Single<UpdatePasswordEntity> {
        let request: ApiRequest<UpdatePasswordEntity> = ExtendedApiRequest.updateUserPass(userId: userId, user: user)
        return apiClient.execute(request: request)
    }
}
