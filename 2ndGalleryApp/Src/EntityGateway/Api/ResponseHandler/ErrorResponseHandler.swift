//
//  ErrorResponseHandler.swift
//  2ndGalleryApp
//
//  Created by Роман on 15.07.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

open class ErrorResponseHandler: ResponseHandler {
    private let exceptions = [String]()

    private let jsonDecoder = JSONDecoder()

    // swiftlint:disable superfluous_disable_command function_body_length
    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        guard let data = response.data  else {
            return false
        }
        
        if data.count == 0 {
            observer(.success(DeleteUserEntity() as! T))
            return true
        }
        guard let urlResponse = response.urlResponse,
            let nsHttpUrlResponse = urlResponse as? HTTPURLResponse else {
                return false
        }
        
        if let host = nsHttpUrlResponse.url?.host,
            exceptions.first?.contains(host) ?? false {
            let errorEntity = ResponseErrorEntity(response.urlResponse)
            
            switch nsHttpUrlResponse.statusCode {
            case 204:
                return true
            case 408:

                return true

            case 500:
                return true

            case 502:
                return true

            case 503:
                return true

            case 504:
                return true

            case 404:
                // When performing a resumable upload, handle 404 Not Found errors
                //  by starting the entire upload over from the beginning.
                                
                errorEntity.errors.append("Somethig went wrong!")
                observer(.error(errorEntity))
                return true

            default:
                break
            }
            
            return false
            
        } else if (300..<600).contains(nsHttpUrlResponse.statusCode) {
            let errorEntity = ResponseErrorEntity(response.urlResponse)

            if response.data != nil {

//                if let responseAuthError = try? jsonDecoder.decode(AuthErrorResponseEntity.self, from: data) {
//                    let error = responseAuthError.error_description
//                    errorEntity.errors.append(error)
//                }

//                if let responseError = try? jsonDecoder.decode(Errors.self, from: data) {
//                    if let violations = responseError.violations {
//                        let error = violations.reduce("", { (result, elem) in result +
//                            (elem.localizePropertyPath) + ": " +
//                            (elem.message ?? "") })
//                        errorEntity.errors.append(error != "" ? error : responseError.detail)
//                    } else {
//                        errorEntity.errors.append(responseError.detail)
//                    }
//                }

                #if DEBUG
                var debugDescription = [String]()
                debugDescription.append("|| \(nsHttpUrlResponse.statusCode) ||\n")
                switch nsHttpUrlResponse.statusCode {
                case (300..<400):
                    debugDescription.append("Неверный редирект.\n")

                case (400..<500):
                    debugDescription.append("Неверный запрос.\n")

                case (500..<600):
                    debugDescription.append("Ошибка сервера.\n")

                default:
                    debugDescription.append("Неизвестная ошибка.\n")
                }
                errorEntity.errors.insert(contentsOf: debugDescription, at: 0)
                #endif
            }

            observer(.error(errorEntity))
            return true
        }
        return false
    }
    // swiftlint:enable function_body_length
}

public class ResponseErrorEntity: LocalizedError {

    public var errors = [String]()
    public let urlResponse: URLResponse?
    public let urlRequest: URLRequest?
    public var statusCode: Int? {
        return (urlResponse as? HTTPURLResponse)?.statusCode
    }


    public init(_ urlResponse: URLResponse? = nil, _ urlRequest: URLRequest? = nil) {
        self.urlResponse = urlResponse
        self.urlRequest = urlRequest
    }

    public var errorDescription: String? {
        return errors.joined()
    }
}

class NSErrorResponseHandler: ResponseHandler {

    public init() {
    }

    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        if let error = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = error.code == -1001 ? error.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : error.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.error(errorResponseEntity))
            return true
        }
        
        if let nextError = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = nextError.code == -400 ? nextError.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : nextError.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.error(errorResponseEntity))
            return true
        }
        
        if let nextNextError = (response.error as NSError?) {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorDesc = nextNextError.code == 400 ? nextNextError.localizedDescription + "\n" /*+ R.string.localizable.tryAgain() LOCALIZABLE */ : nextNextError.localizedDescription
            errorResponseEntity.errors.append(errorDesc)
            observer(.error(errorResponseEntity))
            return true
        }
        return false
    }
}

struct ApiDefaultAnswerEntity: Codable, JsonBodyConvertible {
    var message: String?
}

