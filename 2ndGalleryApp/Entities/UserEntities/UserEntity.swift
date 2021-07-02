//
//  UserEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxNetworkApiClient

class UserEntity: Codable, JsonBodyConvertible {
    var id: Int?
    var name: String?
    var email: String?
    var dateOfBirth: String?
    
    init(user: SignUpEntity) {
        self.name = user.username
        self.email = user.email
        self.email = user.dateOfBirth
    }
}

class UserApiEntity: JsonBodyConvertible {
    var id: Int?
    var name: String?
    var email: String?
    var dateOfBirth: String?
    
    init(user: UserEntity) {
        self.name = user.name
        self.email = user.email
        self.email = user.dateOfBirth
        
    }
}
