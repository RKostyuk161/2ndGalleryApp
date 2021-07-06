//
//  ApiBaseGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import RxNetworkApiClient

class ApiBaseGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}
