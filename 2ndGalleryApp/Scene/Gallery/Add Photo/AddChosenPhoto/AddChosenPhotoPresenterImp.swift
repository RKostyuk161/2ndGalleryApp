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
    var view: AddChosenPhotoViewController
    var router: AddChosenPhotoRouter
    var settings: Settings
    var usecase: UserUseCase
    var disposeBag = DisposeBag()
    var image: UIImage
    var model = ImageEntity()
    
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
        return usecase.addPhoto(image: image, name: name, description: description)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.view.presentedViewController?.dismiss(animated: true, completion: nil)
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Alerts().addAlert(alertTitle: "Succsess",
                                      alertMessage: nil,
                                      buttonMessage: "Ok",
                                      view: self.view,
                                      function: { [weak self] in
                                        self?.route()
                                      })
                }
            },
            onError: { error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Alerts().addAlert(alertTitle: "Error",
                                  alertMessage: error.localizedDescription,
                                  buttonMessage: "Ok",
                                  view: self.view)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func takeFullImageRequest() {
        let imageData = usecase.imageModel
        guard let name = imageData.name,
              let desc = imageData.description,
              let imageName = imageData.image?.name else { return }
        self.model.name = name
        self.model.description = desc
        self.model.image?.name = imageName
        print("model id = \(imageData.id)")
        print("model name = \(imageData.name)")
        route()
    }
    
    func route() {
        router.openProfileImage()
    }
}
