//
//  PaginationEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation

class PaginationEntity<T: Codable>: Codable {
    var totalItems: Int
    var countOfPages: Int
    var items: [T]
    
    init(totalItems: Int, countOfPages: Int, items: [T]) {
        self .totalItems = totalItems
        self.countOfPages = countOfPages
        self.items = items
    }
    
}
