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
    var data: Data
    var name: String?
    var description: String?
    var mimeType: String
    var file: String?
    var id: Int?
    
    public init(name: String, data: Data, mimeType: String) {
        self.name = name
        self.data = data
        self.mimeType = mimeType
    }
}

