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
    
    func setTextFields() {
        guard let userEntity = settings.account else { return }
        view.usernameTextField.text = userEntity.name ?? "no data"
        view.birthTextField.text = userEntity.birthday ?? "no data"
        view.emailTextField.text = userEntity.email ?? "no data"
        
    }
    
    func saveSettings(image: UIImage?) {
        guard let image = image else { return }
        guard let settings = settings.account,
              let id = settings.id else { return }
        let user = UserEntity(id: id,
                              name: view.usernameTextField.text,
                              email: view.emailTextField.text,
                              pass: view.oldPassTextField.text,
                              dateOfBirth: view.birthTextField.text)
        userUseCase.updateUserInfo(user: user, jpgData: AddPhoto(image: image).image)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                
            },
            onDispose: {
                
            })
            .subscribe(onCompleted: { [weak self] in
                guard let view = self?.view else { return }
                Alerts().addAlert(alertTitle: "Success",
                                  alertMessage: nil,
                                  buttonMessage: "Ok",
                                  view: view,
                                  function: { [weak self] in
                                    self?.moveBack()
                                  })
            },
            onError: { error in
                Alerts().addAlert(alertTitle: "Error",
                                  alertMessage: error.localizedDescription,
                                  buttonMessage: "Ok",
                                  view: self.view)
                
            })
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
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: {
                Alerts().addAlert(alertTitle: "Acc is deleted", alertMessage: nil, buttonMessage: "ok", view: self.view, function: {
                        [weak self] in
                        self!.changeRootView()
                    })
                    return
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
    
    func moveBack() {
        self.view.navigationController?.popViewController(animated: true)
    }
}
