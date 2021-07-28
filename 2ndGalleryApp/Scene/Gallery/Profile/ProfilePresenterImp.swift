//
//  ProfilePresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import RxSwift

class ProfilePresenterImp: ProfilePresenter {
    
    var userUseCase: UserUseCase
    var view: ProfileViewController
    var router: ProfileRouter
    var settings: Settings
    var disposeBag = DisposeBag()
    var secondDisposeBag = DisposeBag()
    var isLoadingInProgress = false
    var userPhotoItems = [ImageEntity]()
    
    init(view: ProfileViewController, router: ProfileRouter, settings: Settings, useCase: UserUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.userUseCase = useCase
    }
    
    func routeToSettings() {
        router.openProfileSettingsViewCOntroller(currentUser: view.currentUser)
    }
    
    func subscribeOnUserImages() {
        userUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [ImageEntity]) in
                guard let self = self else { return }
                    self.userPhotoItems = result
                print("dnejfnwjenfjwenfjnwejfwje", self.userPhotoItems)
                    if self.userPhotoItems.isEmpty {
                        self.view.showErrorOnGallery(show: true)
                    } else {
                        self.view.showErrorOnGallery(show: false)
                    }
                    self.view.usersPostsCollectionView.reloadData()
                })
            .disposed(by: secondDisposeBag)
            
    }
    
    func getCurrentUserImages() {
        if !isLoadingInProgress {
            isLoadingInProgress = true
            guard let userId = settings.account?.id else { return }
            userUseCase.getUserImages(userId: userId)
                .observeOn(MainScheduler.instance)
                .do(onDispose: {
                    self.isLoadingInProgress = false
                    self.view.usersPostsCollectionView.reloadData()
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    Alerts().addAlert(alertTitle: "User Images Error",
                                      alertMessage: error.localizedDescription,
                                      buttonMessage: "OK",
                                      view: self.view)
                })
                .disposed(by: disposeBag)
        } else {
            return
        }
    }
}
