//
//  ImageUseCaseImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ImageUseCaseImp: ImageUseCase {

    
    var source = PublishSubject<[ImageEntity]>()
    var userTotalItemsOfImages: Int = 0
    var userItems = [ImageEntity]()

    
    var settings: Settings
    let imageGateway: ImagesGateway
    var photo = FileEntity()
    var uploadPhoto = UploadPhoto(name: nil, description: nil, id: 0)
    var imageModel = ImageEntity()
    var disposeBag = DisposeBag()
    
    init(settings: Settings, imageGateway: ImagesGateway) {
        self.settings = settings
        self.imageGateway = imageGateway
    }
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable {
        guard let data = image.jpegData(compressionQuality: 50) else { return .empty() }
        let photoToAdd = UploadFile("file", data, "image")
        return self.imageGateway.addPhoto(addPhoto: photoToAdd)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] response in
                guard let self = self,
                      let id = response.id else { return }
                self.photo = response
                
                self.uploadPhoto = UploadPhoto(name: name,
                                               description: description,
                                               id: id)
            }, onError: { error in
                print("add error")
            })
            .flatMapCompletable { result -> Completable in
                self.postPhoto(photo: self.uploadPhoto)
            }

    }
    
    func postPhoto(photo: UploadPhoto) -> Completable {
        return self.imageGateway.uploadPhotoDetails(photo: photo)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.imageModel = response
            })
            .asCompletable()
    }
    
    func getUserImages(userId: Int) -> Completable {
        cancelLoading()
        return self.imageGateway.getUserImages(userId: userId)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] result in
                guard let self = self else { return }
                guard let data = result.data else { return }
                self.userTotalItemsOfImages = result.totalItems!
                self.userItems = data
                self.source.onNext(self.userItems)
            },
            onError: { error in
                print(error.localizedDescription)
            })
            .asCompletable()
    }
    
    func cancelLoading() {
        disposeBag = DisposeBag()
    }
}
