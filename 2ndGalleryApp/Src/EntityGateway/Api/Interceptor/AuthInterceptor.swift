//
//  AuthInterceptor.swift
//  2ndGalleryApp
//
//  Created by Роман on 09.07.2021.
//

import Foundation
import RxNetworkApiClient

class AuthInterceptor: Interceptor {
  
    let settings: Settings
    let exceptions = [String]()

    init(_ settings: Settings) {
        self.settings = settings
    }
    
    func prepare<T: Codable>(request: ApiRequest<T>) {
        
        guard !self.exceptions.contains(request.endpoint.host) else {
            return
        }
        
        if request.path?.contains("oauth") != true {
            let authHeaderKey = "Authorization"
            
            let index = request.headers?.firstIndex(where: { $0.key == authHeaderKey })
            if let auth = settings.token {
                let authHeader = Header(authHeaderKey, "Bearer \(auth.access_token)")
                if index == nil {
                    if request.headers == nil {
                        request.headers = [authHeader]
                    } else {
                        request.headers!.append(authHeader)
                    }
                } else {
                    request.headers![index!] = authHeader
                }
            }
        }
    }
    func handle<T>(request: ApiRequest<T>, response: NetworkResponse) where T : Decodable, T : Encodable {
        
    }
}
