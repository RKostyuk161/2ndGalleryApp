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
    
    var view: ProfileSettingsViewController
    var userUseCase: UserUseCase
    var router: ProfileSettingsRouter
    var settings: Settings
    var disposeBag = DisposeBag()
    
    init(view: ProfileSettingsViewController,
         router: ProfileSettingsRouter,
         settings: Settings,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.userUseCase = userUseCase
    }
    
    func saveSettings() {
        
    }
    
    func updatePhoto(image: UIImage) {
        
    }
    func deleteAcc() {
        userUseCase.deleteUser()
            .do(onSubscribe: {
                self.prnt()
            },
            onDispose: {
                self.prnt()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                Alerts().addAlert(alertTitle: "Acc is deleted", alertMessage: nil, buttonMessage: "ok", view: self.view, function: {
                    [weak self] in
                    self!.changeRootView()
                })
            }, onError: { [weak self] error in
                guard let self = self else { return }
                Alerts().addAlert(alertTitle: "Error", alertMessage: error.localizedDescription, buttonMessage: "Ok", view: self.view)
            })
            .disposed(by: disposeBag)
        
    }
    func prnt() {
        print("kkkk")
    }
    func changeRootView()  {
        settings.clearUserData()
        let mainTabBar = R.storyboard.main.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
}
