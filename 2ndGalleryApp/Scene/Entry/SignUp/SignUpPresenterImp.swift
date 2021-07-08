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
    let userUsecase: UserUseCase
    let settings: Settings
    let router: SignUpRouter
    var disposeBag = DisposeBag()
    
    init(view: SignUpViewController, registrationUseCase: RegistrationUseCase, userUseCase: UserUseCase, settings: Settings, router: SignUpRouter) {
        self.view = view
        self.registrationUseCase = registrationUseCase
        self.userUsecase = userUseCase
        self.settings = settings
        self.router = router
    }
    
    func signUp(user: SignUpEntity) {
        self.registrationUseCase.signUp(entity: user)
            .asCompletable()
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
// TODO: activityIndicator on
            }, onDispose: {
// TODO: activityIndicator off
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let user = self.settings.account else {
                    return
                }
                
                print("\(user) useruseruser")
                
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
