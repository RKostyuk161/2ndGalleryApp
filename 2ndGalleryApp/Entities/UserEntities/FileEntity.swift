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


//import AVFoundation
//
//class CacheUtil {
//
//    /**
//     Кеширует некешированное и возвращает ссылку на кеш вместо ссылки на внешний ресурс.
//     - Parameter remoteUrl: URL файла на внешнем ресурсе
//     - Returns: URL локального файла
//
//     - Remark:
//     Кеш необходимо очищать.
//    */
//    class func cached(remoteUrl: URL) throws -> URL {
//
//        let path = "cached_\(remoteUrl.path.hash)_\(remoteUrl.pathComponents.last ?? "X")"
//
//        let outputURL = FileManager.default.temporaryDirectory
//            .appendingPathComponent(path)
//
//        if FileManager.default.fileExists(atPath: path) {
//            return outputURL
//        } else {
//            DispatchQueue.global(qos: .utility).async {
//                try? Data(contentsOf: remoteUrl).write(to: outputURL)
//            }
//            return remoteUrl
//        }
//    }
//
//    class func cleanCache() {
//        do {
//            let fileManager = FileManager.default
//            let tmpDirURL = fileManager.temporaryDirectory
//            guard let tmpDirectory = try? fileManager.contentsOfDirectory(atPath: tmpDirURL.path) else {
//                return
//            }
//            tmpDirectory
//                .forEach { file in
//                    let fileUrl = tmpDirURL.appendingPathComponent(file)
//                    try? fileManager.removeItem(atPath: fileUrl.path)
//                }
//        }
//    }
//}
