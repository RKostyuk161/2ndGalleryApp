//
//  ProfileSettingPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit
import RxSwift

class ProfileSettingsPresenterImp: ProfileSettingsPresenter {
    
    weak var view: ProfileSettingsView!
    var userUseCase: UserUseCase
    var router: ProfileSettingsRouter
    var settings: Settings
    var disposeBag = DisposeBag()
    var currentUser: UserEntity
    
    
    init(view: ProfileSettingsViewController,
         router: ProfileSettingsRouter,
         settings: Settings,
         userUseCase: UserUseCase,
         currentUser: UserEntity) {
        self.view = view
        self.router = router
        self.settings = settings
        self.userUseCase = userUseCase
        self.currentUser = currentUser
    }
    
    func setTextFields() {
        self.view.setTextFields()
    }
    
    func saveSettings() {
        
        let user = self.view.routeUsersData()
        userUseCase.updateUserInfo(user: user)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.router.dismissPresentedController()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                    self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.succsessMessage(),
                                                    alertMessage: nil,
                                                    buttonMessage: R.string.alert.okMessage(),
                                                    completion: { [ weak self ] in
                                                        self?.router.dismissPresentedController()
                                                        self?.saveDataAndPopController()
                                                    })
            },
            onError: { error in
                    self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.errorMessage(),
                                                    alertMessage: error.localizedDescription,
                                                    buttonMessage: R.string.alert.okMessage())
                
            })
            .disposed(by: disposeBag)
    }
    
    func updatePass(oldPass: String, newPass: String)  {
        let user = UpdatePasswordEntity(oldPass: oldPass, newPass: newPass)
        userUseCase.updateUserPass(user: user)
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [ weak self ] in
                guard let self = self else { return }
                self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.succsessMessage(),
                                                 alertMessage: nil,
                                                 buttonMessage: R.string.alert.okMessage(),
                                                 completion: { [ weak self ] in
                                                    self?.saveDataAndPopController()
                                                 })
            }, onError: { error in
                self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                        alertMessage: error.localizedDescription,
                                        buttonMessage: R.string.alert.okMessage())
            })
            .disposed(by: disposeBag)
    }

    func deleteAcc() {
        userUseCase.deleteUser()
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.router.dismissPresentedController()
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: {
                
                self.view.addInfoModuleWithFunc(alertTitle: R.string.alert.accIsDeleteMessage(),
                                                alertMessage: nil,
                                                buttonMessage: R.string.alert.okMessage(),
                                                completion: { [ weak self ] in
                                                    self?.settings.clearUserData()
                                                    self?.changeRootView()
                                                })
            }, onError: { [weak self] error in
                guard error is ResponseErrorEntity else { return }
                guard let self = self else { return }
                self.view.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                        alertMessage: error.localizedDescription,
                                        buttonMessage: R.string.alert.okMessage())
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func changeRootView()  {
        settings.clearUserData()
        router.routeToStartView()
    }
    
    func saveDataAndPopController() {
        router.routeToProfile(currentUser: currentUser)
    }
}
