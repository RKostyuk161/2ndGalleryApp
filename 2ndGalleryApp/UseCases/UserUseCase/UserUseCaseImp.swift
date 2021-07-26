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
            })
            .asCompletable()
    }
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable {
        let photo = Photo(name: name, description: description, id: name)
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters)
        guard let imageToString: String = image.pngData()?.description else { return .empty()}
        let photoDetails = AddPhoto(image: imageStr!, name: name)
        return self.userGateway.addPhoto(addPhoto: photoDetails)
            .asCompletable()
            .andThen(userGateway.uploadPhotoDetails(photoDetails: photoDetails))
            .asCompletable()
        

    }
}

enum UserUseCaseError: LocalizedError {
    case localUserIdIsNil
    case remoteUserIdIsNil
}
