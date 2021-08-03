//
//  AddChosenPhotoPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import UIKit
import RxSwift

class AddChosenPhotoPresenterImp: AddChosenPhotoPresenter {
    var view: AddChosenPhotoView
    var router: AddChosenPhotoRouter
    var settings: Settings
    var usecase: UserUseCase
    var disposeBag = DisposeBag()
    var image: UIImage
    var model = ImageEntity()
    var isLoadingInProgress = false
    
    init(view: AddChosenPhotoViewController,
         router: AddChosenPhotoRouter,
         image: UIImage,
         settings: Settings,
         usecase: UserUseCase) {
        self.view = view
        self.router = router
        self.image = image
        self.settings = settings
        self.usecase = usecase
    }
    
    func addPhoto(image: UIImage, name: String, description: String) {
        if !isLoadingInProgress {
            isLoadingInProgress = true
    
        return usecase.addPhoto(image: image, name: name, description: description)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.isLoadingInProgress = false
                self.view.dismissPresentedController()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.succsessMessage(),
                                                    alertMessage: nil,
                                                    buttonMessage: R.string.alert.okMessage(),
                                                    completion: { [weak self ] in
                                                        self?.routeToProfileImage()
                                                    })
                }
            },
            onError: { error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                            alertMessage: error.localizedDescription,
                                            buttonMessage: R.string.alert.okMessage())
                }
            })
            .disposed(by: disposeBag)
        } else {
            return
        }
    }
    
    func takeFullImageRequest() {
        let imageData = usecase.imageModel
        guard let name = imageData.name,
              let desc = imageData.description,
              let imageName = imageData.image?.name else { return }
        self.model.name = name
        self.model.description = desc
        self.model.image?.name = imageName
        routeToProfileImage()
    }
    
    func routeToProfileImage() {
        router.openProfileImage()
    }
}
