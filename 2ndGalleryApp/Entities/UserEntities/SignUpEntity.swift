//
//  SignUpEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 28.06.2021.
//

import Foundation
import RxNetworkApiClient

public struct SignUpEntity: Codable, JsonBodyConvertible {
    var username: String?
    var dateOfBirth: String?
    var email: String?
    var pass: String?
    
}
