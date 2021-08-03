//
//  CheckUserEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxNetworkApiClient

class CheckUserEntity: JsonBodyConvertible {
    var userId: String?
    var username: String?
    var secret: String?
    var allowedGrantTypes: [String?]
}
