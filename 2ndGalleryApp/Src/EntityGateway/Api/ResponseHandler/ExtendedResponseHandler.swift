//
//  ExtendedResponseHandler.swift
//  2ndGalleryApp
//
//  Created by Роман on 07.07.2021.
//

import Foundation
import RxSwift
import SwiftyJSON
import RxNetworkApiClient

typealias ResponseHeader = [AnyHashable : Any]?

protocol EntityWithHeaders {
    var responseHeader: ResponseHeader { get set }
    
}

class ExtedndedResponseHandler: ResponseHandler {
    
    init() {
    }
    
    let decoder = JSONDecoder()
    
    func handle<T>(observer: @escaping SingleObserver<T>,
                   request: ApiRequest<T>,
                   response: NetworkResponse) -> Bool where T : Decodable, T : Encodable {
        
        if let data = response.data {
            do {
                if T.self == JSON.self {
                    let json = try JSON(data: data)
                    observer(.success(json as! T))
                } else if T.self == Data.self {
                    observer(.success(data as! T))
                    
                } else {
                    
                    let result = try decoder.decode(T.self, from: data)
                    
                    guard let resultWithHeaders = result as? EntityWithHeaders else {
                        observer(.success(result))
                        return true
                    }
                    let response = response.urlResponse as? HTTPURLResponse
                    var finalResult = resultWithHeaders
                    finalResult.responseHeader = response?.allHeaderFields
                    observer(.success(finalResult as! T))
                }
            } catch {
                observer(.error(error))
            }
            return true
        }
        return false
    }
}
