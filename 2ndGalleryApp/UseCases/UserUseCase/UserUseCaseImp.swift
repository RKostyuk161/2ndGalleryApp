//
//  UserUseCaseImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

class UserUseCaseImp: UserUseCase {
    
    var settings: Settings
    let userGateway: UserGateway
    
    init(settings: Settings, userGateway: UserGateway) {
        self.settings = settings
        self.userGateway = userGateway
    }
    
    func getUserInfo() -> Single<UserEntity> {
        return userGateway.getAcc()
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                self?.settings.account = user
            })
    }
    
    func updateUserInfo(user: UserEntity, jpgData: Data?) -> Completable {
//        TODO: update with photo
        guard let userId = settings.account?.id else {
            return .error(UserUseCaseError.localUserIdIsNil)
        }
        return self.userGateway.updateUserInfo(userId: userId, user: UserApiEntity(user: user))
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [ weak self ] newUserInfo in
                self?.settings.account = newUserInfo
            })
            .asCompletable()
    }
    func deleteUser() -> Completable {
        guard let userId = settings.account?.id else {
            return .error(UserUseCaseError.localUserIdIsNil)
        }
        return self.userGateway.deleteUser(id: userId)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                self?.settings.account = nil
                self?.settings.token = nil
            })
            .asCompletable()
    }
}

enum UserUseCaseError: LocalizedError {
    case localUserIdIsNil
    case remoteUserIdIsNil
}
