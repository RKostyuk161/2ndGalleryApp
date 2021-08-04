//
//  UserUseCaseImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class UserUseCaseImp: UserUseCase {
    
    var userSource = PublishSubject<UserEntity>()
    var userTotalItemsOfImages: Int = 0
    var userItems = [ImageEntity]()
    var settings: Settings
    let userGateway: UserGateway
    var disposeBag = DisposeBag()
    var userModel = UserEntity(user: SignUpEntity())
    
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
    
    func updateUserInfo(user: UserEntity) -> Completable {
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
    
    func updateUserPass(user: UpdatePasswordEntity) -> Completable {
        guard let userId = settings.account?.id else {
            return .error(UserUseCaseError.localUserIdIsNil)
        }
        return self.userGateway.updateUserPass(userId: userId, user: user)
            .observeOn(MainScheduler.instance)
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
            },
            onError: { error in
                print("delete error")
            })
            .asCompletable()
    }
    
    func getUserModel(id: String) -> Completable {
        return userGateway.getUserModel(id: id)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] user in
                guard let self = self else { return }
                self.userModel = user
                self.userSource.onNext(self.userModel)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .asCompletable()
    }
    
    func cancelLoading() {
        disposeBag = DisposeBag()
    }
}

enum UserUseCaseError: LocalizedError {
    case localUserIdIsNil
    case remoteUserIdIsNil
}
