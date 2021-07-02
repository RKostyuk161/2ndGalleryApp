//
//  ApiEndPoint.swift
//  2ndGalleryApp
//
//  Created by Роман on 01.07.2021.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {
    
    static var webAntApi = ApiEndpoint(Config.apiEndpoint)
    
    static func updateEndpoint() {
        ApiEndpoint.webAntApi = ApiEndpoint(Config.apiEndpoint)
    }
}
