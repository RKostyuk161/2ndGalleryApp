//
//  ImageEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import Foundation

struct ImageEntity: Decodable, Encodable {
    var id: Int?
    var new: Bool?
    var popular: Bool?
    var name: String?
    var description: String?
    var image: ImageInfo?
    var user: Int?
}

