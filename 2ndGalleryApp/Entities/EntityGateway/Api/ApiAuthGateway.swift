//
//  ApiAuthGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiAuthGateway: ApiBaseGateway, AuthGateway {
    
    func auth(username: String, password: String) -> Single<TokenEntity> {
        return apiClient.execute(request: ExtendedApiRequest.loginRequest(login: username, pass: password))
    }
    
    func refreshToken(refreshToken: String) -> Single<TokenEntity> {
        return apiClient.execute(request: ExtendedApiRequest.tokenRefreshRequest(refreshToken: refreshToken))
    }
    
    
}
