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
    var username: String?
    var email: String?
    var password: String?
    var birthday: String?
    
    init(id: Int,
         username: String?,
         email: String?,
         pass: String?,
         dateOfBirth: String?) {
        self.id = id
        self.username = username
        self.email = email
        self.password = pass
        self.birthday = dateOfBirth
    }
    
    init(user: SignUpEntity) {
        self.id = user.id
        self.username = user.username
        self.email = user.email
        self.birthday = user.birthday
        self.password = user.password
    }
}

class UserApiEntity: JsonBodyConvertible {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var birthday: String?
    
    init(id: Int,
         name: String?,
         email: String?,
         pass: String?,
         dateOfBirth: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.password = pass
        self.birthday = dateOfBirth
    }
    
    init(user: UserEntity) {
        self.id = user.id
        self.name = user.username
        self.email = user.email
        self.birthday = user.birthday
        self.password = user.password
    }
}

class UpdatePasswordEntity: JsonBodyConvertible {
    var oldPassword: String
    var newPassword: String
    
    init(oldPass: String, newPass: String) {
        self.oldPassword = oldPass
        self.newPassword = newPass
    }
}
