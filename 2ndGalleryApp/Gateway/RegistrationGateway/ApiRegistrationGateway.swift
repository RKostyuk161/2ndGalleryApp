//
//  ApiRegistrationGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiRegistrationGateway: ApiBaseGateway, RegistrationGateway {
    
    func signUp(entity: SignUpEntity) -> Single<UserEntity> {
        let request: ExtendedApiRequest<UserEntity> = ExtendedApiRequest.signUp(entity: entity)
        return apiClient.execute(request: request)
    }
    
    
}
