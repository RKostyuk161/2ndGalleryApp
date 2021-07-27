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
        view.usernameTextField.text = currentUser.username ?? "no data"
        view.birthTextField.text = currentUser.birthday ?? "no data"
        view.emailTextField.text = currentUser.email ?? "no data"
        
    }
    
    func saveSettings() {
        guard let settings = settings.account,
              let id = settings.id else { return }
        let user = UserEntity(id: id,
                              username: view.usernameTextField.text,
                              email: view.emailTextField.text,
                              pass: view.oldPassTextField.text,
                              dateOfBirth: view.birthTextField.text)
        userUseCase.updateUserInfo(user: user)
            .observeOn(MainScheduler.instance)
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
    
    func updatePass(oldPass: String, newPass: String)  {
        let user = UpdatePasswordEntity(oldPass: oldPass, newPass: newPass)
        userUseCase.updateUserPass(user: user)
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [ weak self ] in
                guard let view = self?.view else { return }
                Alerts().addAlert(alertTitle: "Success",
                                  alertMessage: nil,
                                  buttonMessage: "Ok",
                                  view: view,
                                  function: { [weak self] in
                                    self?.moveBack()
                                  })
            }, onError: { error in
                Alerts().addAlert(alertTitle: "Error",
                                  alertMessage: error.localizedDescription,
                                  buttonMessage: "Ok",
                                  view: self.view)
            })
    }

    func deleteAcc() {
        userUseCase.deleteUser()
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.view.presentedViewController?.dismiss(animated: true, completion: nil)
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Alerts().addAlert(alertTitle: "Acc is deleted", alertMessage: nil, buttonMessage: "ok", view: self.view, function: {
                        [weak self] in
                        self!.changeRootView()
                    })
                    return
                }
            }, onError: { [weak self] error in
                guard let networkError = error as? ResponseErrorEntity else { return }
                guard let self = self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Alerts().addAlert(alertTitle: "Error", alertMessage: networkError.localizedDescription, buttonMessage: "Ok", view: self.view)
                }
            })
            .disposed(by: disposeBag)
        
    }

    func changeRootView()  {
        settings.clearUserData()
        let mainTabBar = R.storyboard.main.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    func moveBack() {
        self.view.navigationController?.popViewController(animated: true)
        ProfileConfigurator.config(view: ProfileViewController(), currentUser: currentUser)
    }
}
