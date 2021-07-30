//
//  AuthUseCaseImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

class AuthUseCaseImp: AuthUseCase {
    var settings: Settings
    let userUseCase: UserUseCase
    var authApi: AuthGateway
    var tokenState: TokenState
    
    init(settings: Settings, userUseCase: UserUseCase, authApi: AuthGateway) {
        self.settings = settings
        self.userUseCase = userUseCase
        self.authApi = authApi
        self.tokenState = settings.token == nil ? .none : .active
    }
    
    func sighIn(login: String, password: String) -> Completable {
        return authProceed(singleToken: self.authApi.auth(username: login, password: password))
    }
    
    func refreshToken() -> Completable {
        let refToken = settings.token?.refresh_token ?? ""
        return authApi.refreshToken(refreshToken: refToken)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { tokenEntity in
                self.settings.token = tokenEntity
            }, onError: { _ in
                self.tokenState = .failedToRefresh
                
            }, onSubscribed: {
                self.tokenState = .refreshing
            }, onDispose: {
                if self.tokenState == .refreshing {
                    self.tokenState = .failedToRefresh
                }
            })
            .asCompletable()
    }
    
    func logout() {
        tokenState = .none
        self.settings.clearUserData()
    }
    
    func authProceed(singleToken: Single<TokenEntity>) -> Completable {
        return singleToken
            .do(onSuccess: { tokenEntity in
                self.settings.token = tokenEntity
                self.tokenState = .active
            }, onSubscribe: {
                self.settings.token = nil
                self.tokenState = .none
            })
            .asCompletable()
            .andThen(self.userUseCase.getUserInfo())
            .asCompletable()
            .do(onCompleted: {
                NotificationCenter.default.post(name: .onUserSignedIn, object: nil)
            })
    }
}

extension Notification.Name {

    static let onUserSignedIn = Notification.Name("onUserSignedIn")
}
