//
//  SignUpPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation
import RxSwift

class SignUpPresenterImp: SignUpPresenter {

    weak var view: SignUpViewController!
    var user = SignUpEntity()
    let registrationUseCase: RegistrationUseCase
    let logingUseCase: AuthUseCase
    let userUsecase: UserUseCase
    let settings: Settings
    let router: SignUpRouter
    var disposeBag = DisposeBag()
    
    init(view: SignUpViewController,
         registrationUseCase: RegistrationUseCase,
         userUseCase: UserUseCase,
         settings: Settings,
         router: SignUpRouter,
         loginUseCase: AuthUseCase) {
        self.view = view
        self.registrationUseCase = registrationUseCase
        self.userUsecase = userUseCase
        self.settings = settings
        self.router = router
        self.logingUseCase = loginUseCase
    }
    
    func signUp(user: SignUpEntity) {
        self.logingUseCase.logout()
        self.registrationUseCase.signUp(entity: user)
            .asCompletable()
            .observeOn(MainScheduler.instance)
            .andThen(self.logingUseCase.sighIn(login: self.view.emailTextField.text!, password: self.view.confirmPassTextField.text!))
            .do(onSubscribe: {
// TODO: activityIndicator on
            }, onDispose: {
// TODO: activityIndicator off
                let storyboard = UIStoryboard(name: "MainGallery", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainGalleryTabBarController") as! UITabBarController
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let user = self.settings.account else {
                    return
                }
                
                
            },

            onError: { [weak self] error in
                print("error is \(error.localizedDescription)")
            })
            
            
            .disposed(by: disposeBag)
    }
    
    func getUser() -> UserEntity? {
        return self.settings.account
    }
    
    func proceed(user: SignUpEntity) {
        
    }
    
    
}
