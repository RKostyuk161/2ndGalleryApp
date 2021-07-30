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

struct UploadPhoto: JsonBodyConvertible {
    var name: String?
    var description: String?
    var image: String?
    var popular: Bool
    var new: Bool
    
    init(name: String?, description: String?, id: Int?, iri: String) {
        self.name = name
        self.description = description
        self.image = "\(iri)\(id ?? 0)"
        self.popular = false
        self.new = true
    }
}
