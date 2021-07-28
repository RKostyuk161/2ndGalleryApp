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
    
    
    var source = PublishSubject<[ImageEntity]>()
    var isLoadingInProcess: Bool = false
    var userTotalItemsOfImages: Int = 0
    var userItems = [ImageEntity]()

    
    var settings: Settings
    let userGateway: UserGateway
    var photo = FileEntity()
    var uploadPhoto = UploadPhoto(name: nil, description: nil, id: 0, iri: "nil")
    var imageModel = ImageEntity()
    var disposeBag = DisposeBag()
    
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
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable {
        guard let data = image.pngData() else { return .empty() }
        let photoToAdd = UploadFile("file", data, "image")
        return self.userGateway.addPhoto(addPhoto: photoToAdd)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] response in
                guard let self = self,
                      let id = response.id else { return }
                self.photo = response
                
                self.uploadPhoto = UploadPhoto(name: name,
                                               description: description,
                                               id: id,
                                               iri: "/api/media_objects/")
            }, onError: { error in
                print("add error")
            })
            .flatMapCompletable({ result -> Completable in
                return self.postPhoto(photo: self.uploadPhoto)
            })

    }
    
    func postPhoto(photo: UploadPhoto) -> Completable {
        return self.userGateway.uploadPhotoDetails(photo: photo)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.imageModel = response
            }, onError: { error in
                print("upload error")
            })
            .asCompletable()
    }
    
    func getUserImages(userId: Int) -> Completable {
        cancelLoading()
        self.isLoadingInProcess = true
        return self.userGateway.getUserImages(userId: userId)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] result in
                guard let self = self else { return }
                guard let data = result.data else { return }
                self.userTotalItemsOfImages = result.totalItems!
                self.userItems = data
                self.source.onNext(self.userItems)
                self.isLoadingInProcess = false
            },
            onError: { error in
                self.isLoadingInProcess = false
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


struct UploadPhoto: JsonBodyConvertible {
    var name: String?
    var description: String?
    var image: String?
    var popular: Bool
    var new: Bool
    
    init(name: String?, description: String?, id: Int?, iri: String) {
        self.name = name
        self.description = description
        self.image = "\(iri)\(id ?? 0)"
        self.popular = false
        self.new = true
    }
}
