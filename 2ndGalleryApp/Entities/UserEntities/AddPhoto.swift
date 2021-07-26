//
//  AddPhoto.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit
import RxNetworkApiClient

struct AddPhoto: Codable, JsonBodyConvertible {
    var file: String
    var name: String
    var id: String?
    
    public init(image: String, name: String) {
        self.file = image
        self.name = name
    }
}

struct Photo: Codable, JsonBodyConvertible {
    var name: String
    var description: String
    var id: String
}
