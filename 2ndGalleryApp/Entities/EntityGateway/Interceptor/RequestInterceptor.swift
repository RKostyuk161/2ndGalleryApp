//
//  RequestInterceptor.swift
//  2ndGalleryApp
//
//  Created by Роман on 15.07.2021.
//

import Foundation
import RxNetworkApiClient

class RequestInterceptor: Interceptor {
    
    
    
    func prepare<T>(request: ApiRequest<T>) where T : Decodable, T : Encodable {
        
    }
    
    func handle<T>(request: ApiRequest<T>, response: NetworkResponse) where T : Decodable, T : Encodable {
    }
    
    
}
