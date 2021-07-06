//
//  Request.swift
//  2ndGalleryApp
//
//  Created by Роман on 30.06.2021.
//

import Foundation
import RxNetworkApiClient
import RxSwift

extension ExtendedApiRequest {
    
    static func loginRequest(login: String, pass: String) -> ExtendedApiRequest {
        return extendedRequest(path: "oauth/v2/token",
                               method: .get,
                               queryArray: ("client_id", Config.clientId),
                               ("client_secret", Config.clientSecret),
                               ("grant_type", "password"),
                               ("username", login),
                               ("password", pass))
    }
    
    static func getAccRequest() -> ExtendedApiRequest {
        return extendedRequest(path: "users/current", method: .get )
    }
    
    static func updateUserUnfo(userId: Int, user: UserApiEntity) -> ExtendedApiRequest {
        return extendedRequest(path: "users/\(userId)",
                               method: .put,
                               headers: [Header.contentJson],
                               body: user)
    }
    
    static func tokenRefreshRequest(refreshToken: String) -> ExtendedApiRequest {
        return extendedRequest(path: "oauth/v2/token",
                               method: .post,
                               formData: ["client_id": Config.clientId,
                                          "client_secret": Config.clientSecret,
                                          "grant_type": "refresh_token",
                                          "refresh_token": refreshToken])
    }
    
    static func signUp(entity: SignUpEntity, locale: String) -> ExtendedApiRequest {
        return extendedRequest(path: "users/",
                               method: .post,
                               headers: [Header.contentJson,
                                         Header("localization", locale)],
                               body: entity,
                               queryArray: ("lang", locale))
    }
    
    static func getGalleryRequest(page: Int,
                                  limit: Int,
                                  currentCollection: CollectionType) -> ExtendedApiRequest {
        
        var galleryStateParametrs: [(String, String?)] = (currentCollection == .new) ? [("new", "true")] : [("new", "false"),("popular", "true")]
        galleryStateParametrs.append(contentsOf: [("page", String(page)),("limit", String(limit))])
        return extendedRequest(path: "media/",
                               method: .get,
                               headers: [Header.contentJson],
                               queryArray: galleryStateParametrs)
    }
}
