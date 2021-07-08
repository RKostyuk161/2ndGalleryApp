//
//  ImageEntities.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation

struct ImageEntities: Decodable, Encodable {
    var itemsPerPage: Int?
    var data: [ImageEntity]?
}
