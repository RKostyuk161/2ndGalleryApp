//
//  DI.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import UIKit
import DITranquillity
import RxNetworkApiClient

class DI {
    static let shared = DI()
    
    static var container = DIContainer()
    static var backgroundContainer = DIContainer()
    
    init() { }
    
    static func initDependencies(appDelegate: AppDelegate) {
        DI.container = DIContainer(parent: backgroundContainer)
        
        ApiEndpoint.baseEndpoint = ApiEndpoint.webAntApi
        
        self.container.register(AuthInterceptor.init)
            .as(AuthInterceptor.self)
            .lifetime(.single)
        
        self.container.register { () -> ApiClientImp in
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 60 * 20
            config.timeoutIntervalForResource = 60 * 20
            config.waitsForConnectivity = true
            config.shouldUseExtendedBackgroundIdleMode = true
            config.urlCache?.removeAllCachedResponses()
            let client = ApiClientImp(urlSessionConfiguration: config, completionHandlerQueue: .main)
            client.responseHandlersQueue.append(ErrorResponseHandler())
            client.responseHandlersQueue.append(JsonResponseHandler())
            client.responseHandlersQueue.append(NSErrorResponseHandler())

            return client
        }
        .as(ApiClient.self)
        .lifetime(.single)
        .injection(cycle: true) {
            $0.interceptors.insert($1 as AuthInterceptor, at: 0)
        }
        
        self.container.register(UserDefaultsSettings.init)
            .as(UserDefaultsSettings.self)
            .lifetime(.single)
        
        self.container.register { LocalSettings(userDefaults: $0) }
            .as(Settings.self)
            .lifetime(.single)
        
        self.container.register(ApiAuthGateway.init)
            .as(AuthGateway.self)
            .lifetime(.single)
        
        self.container.register(ApiUserGateway.init)
            .as(UserGateway.self)
            .lifetime(.single)
        
        self.container.register(ApiRegistrationGateway.init)
            .as(RegistrationGateway.self)
            .lifetime(.single)
        
        self.container.register(ApiGalleryPaginationGateway.init)
            .as(GalleryPaginationGateway.self)
            .lifetime(.single)
        
        
        self.container.register(AuthUseCaseImp.init)
            .as(AuthUseCase.self)
        
        self.container.register(RegistrationUseCaseImp.init)
            .as(RegistrationUseCase.self)
        
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
        
        self.container.register { PaginationUseCaseImp(gateway: $0,
                                                     settings: $1) }
            .as(PaginationUseCase.self)
    }
    
    static func resolve<T>() -> T {
        return self.container.resolve()
    }
    
    static func resolveBackground<T>() -> T {
        return self.backgroundContainer.resolve()
    }
}
