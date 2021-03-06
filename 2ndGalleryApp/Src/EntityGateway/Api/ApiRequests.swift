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
        return extendedRequest(path: "/oauth/v2/token",
                               method: .get,
                               queryArray: ("client_id", Config.clientId),
                               ("client_secret", Config.clientSecret),
                               ("grant_type", "password"),
                               ("username", login),
                               ("password", pass))
    }
    
    static func getAccRequest() -> ExtendedApiRequest {
        return extendedRequest(path: "/api/users/current",
                               method: .get)
    }
    
    static func getAccModel(id: String) -> ExtendedApiRequest {
        return extendedRequest(path: id,
                               method: .get)
    }
    
    static func updateUserUnfo(userId: Int, user: UserApiEntity) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/users/\(userId)",
                               method: .put,
                               headers: [Header.contentJson],
                               body: user)
    }
    
    static func updateUserPass(userId: Int, user: UpdatePasswordEntity) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/users/update_password/\(userId)",
                               method: .put,
                               headers: [Header.contentJson],
                               body: user)
    }
    
    static func tokenRefreshRequest(refreshToken: String) -> ExtendedApiRequest {
        return extendedRequest(path: "/oauth/v2/token",
                               method: .post,
                               formData: ["client_id": Config.clientId,
                                          "client_secret": Config.clientSecret,
                                          "grant_type": "refresh_token",
                                          "refresh_token": refreshToken])
    }
    
    static func signUp(entity: SignUpEntity) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/users",
                               method: .post,
                               headers: [Header.contentJson],
                               body: entity)
    }
    
    static func getGalleryRequest(page: Int,
                                  limit: Int,
                                  currentCollection: CollectionType) -> ExtendedApiRequest {
        
        var galleryStateParametrs: [(String, String?)] = (currentCollection == .new)
            ? [("new", "true")]
            : [("new", "false"),("popular", "true")]
        galleryStateParametrs.append(contentsOf: [("page", String(page)),
                                                  ("limit", String(limit))])
        return extendedRequest(path: "/api/photos/",
                               method: .get,
                               headers: [Header.contentJson],
                               queryArray: galleryStateParametrs)
    }
    
    static func deleteUserRequest(id: Int) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/users/\(id)",
                               method: .delete)
    }
    
    static func getFullImageRequest(imageName: String) -> ExtendedApiRequest {
        return extendedRequest(path: "/media/\(imageName)",
                               method: .get)
    }
    
    static func addPhotoRequest(addPhoto: UploadFile) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/media_objects",
                               method: .post,
                               files: [addPhoto])
    }
    
    static func uploadPhotoRequest(photo: UploadPhoto) -> ExtendedApiRequest {
        return extendedRequest(path: "/api/photos",
                               method: .post,
                               headers: [Header.contentJson],
                               body: photo)
    }
    
    static func searchPhotosRequest(imageName: String,
                                    currentCollection: CollectionType) -> ExtendedApiRequest {
        var searchStateParametrs: [(String, String?)] = (currentCollection == .new)
            ? [("new", "true")]
            : [("new", "false"),("popular", "true")]
        searchStateParametrs.append(contentsOf: [("name", imageName)])
        return extendedRequest(path: "/api/photos",
                               method: .get,
                               headers: [Header.contentJson],
                               queryArray: searchStateParametrs)
    }
    
    static func searchUsersPhotoRequest(userId: Int) -> ExtendedApiRequest {
        let searchStateParametrs = [("user.id", "\(userId)")]
        return extendedRequest(path: "/api/photos",
                               method: .get,
                               headers: [Header.contentJson],
                               queryArray: searchStateParametrs)
    }
}
