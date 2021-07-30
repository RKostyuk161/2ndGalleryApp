//
//  FileEntity.swift
//  2ndGalleryApp
//
//  Created by Роман on 27.07.2021.
//

import Foundation
import RxNetworkApiClient

final class FileEntity: Codable {

    var id: Int?
    var name: String?
    var path: String?
    var isFullPath: Bool?
    var iri: String? {
        guard let fileId = self.id else {
            return nil
        }
        return "\(Config.iriEndpoint)\(fileId)"
    }
    
    init(id: Int? = nil,
         name: String? = nil,
         path: String? = nil,
         isFoolPath: Bool? = nil) {
        self.id = id
        self.name = name
        self.path = path
    }
}

extension FileEntity: BodyConvertible {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case path
    }
    
    func createBody() -> Data {
        let jsonEncoder = JSONEncoder()
        return try! jsonEncoder.encode(self)
    }
}
