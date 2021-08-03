//
//  TokenEntitiy.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation

class TokenEntity: Codable {
    var access_token: String
    var refresh_token: String
    
    init(accessToken: String, refreshToken: String) {
        self.access_token = accessToken
        self.refresh_token = refreshToken
    }
}
