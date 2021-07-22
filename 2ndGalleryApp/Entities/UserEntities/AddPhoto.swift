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
    var image: Data
    
    
    public init(image: UIImage) {
        self.image = image.pngData()!
    }
}

struct Photo: Codable, JsonBodyConvertible {
    var name: String
    var description: String
    var image: PhotoDetails
}

struct PhotoDetails: Codable {
    var name: String
}
