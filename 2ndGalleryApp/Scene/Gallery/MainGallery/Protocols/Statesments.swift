//
//  Statesments.swift
//  2ndGalleryApp
//
//  Created by Роман on 15.06.2021.
//

import Foundation

enum CollectionType: Int {
    case new = 0
    case popular = 1
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .new
        case 1:
            self = .popular
        default:
            return nil
        }
    }
}

enum GalleryType: Int {
    case gallery = 0
    case search = 1
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .gallery
        case 1:
            self = .search
        default:
            return nil
        }
    }
}
