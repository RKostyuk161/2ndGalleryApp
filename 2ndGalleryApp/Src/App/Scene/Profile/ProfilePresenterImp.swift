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
    var view: ProfileView
    var router: ProfileRouter
    var settings: Settings
    var disposeBag = DisposeBag()
    var secondDisposeBag = DisposeBag()
    var isLoadingInProgress = false
    var userPhotoItems = [ImageEntity]()
    var currentUser = UserEntity(user: SignUpEntity())
    
    init(view: ProfileViewController, router: ProfileRouter, settings: Settings, useCase: UserUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.userUseCase = useCase
    }
    
    func routeToSettings() {
        router.openProfileSettingsViewCOntroller(currentUser: currentUser)
    }
    
    func subscribeOnUserImages() {
        userUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result: [ImageEntity]) in
                guard let self = self else { return }
                    self.userPhotoItems = result
                    if self.userPhotoItems.isEmpty {
                        self.view.showErrorOnGallery(show: true)
                    } else {
                        self.view.showErrorOnGallery(show: false)
                    }
                    self.view.collectionViewReloadData()
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
                    self.view.collectionViewReloadData()
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else { return }
                    self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                            alertMessage: error.localizedDescription,
                                            buttonMessage: R.string.alert.okMessage())
                })
                .disposed(by: disposeBag)
        } else {
            return
        }
    }
    
    func getUser() -> UserEntity? {
        return settings.account
    }
    
    func setUser() {
        guard let user = getUser() else { return }
        self.currentUser = user
    }
}
