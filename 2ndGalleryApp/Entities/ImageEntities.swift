//
//  ImageEntities.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation

struct ImageEntities: Decodable {
    var countOfPages: Int?
    var data: [ImageEntity]?
}

struct ImageEntity: Decodable {
    var id: Int?
    var new: Bool?
    var popylar: Bool?
    var name: String?
    var description: String?
    var image: ImageInfo?
}

struct ImageInfo: Decodable {
    var name: String?
    var id: Int?
}
