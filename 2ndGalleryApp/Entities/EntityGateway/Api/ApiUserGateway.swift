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
    
    
    func deleteUser(id: Int) -> Single<UserEntity> {
        return apiClient.execute(request: ExtendedApiRequest.deleteUserRequest(id: id))
    }
    
    
    func getAcc() -> Single<UserEntity> {
        return apiClient.execute(request: ExtendedApiRequest.getAccRequest())
    }
    
    func updateUserInfo(userId: Int, user: UserApiEntity) -> Single<UserEntity> {
        let request: ApiRequest<UserEntity> = ExtendedApiRequest.updateUserUnfo(userId: userId, user: user)
        return apiClient.execute(request: request)
    }
    
    
}
