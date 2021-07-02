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
    let registrationUseCase: RegistrationUseCase
    let userUsecase: userUseCase
    let settings: Settings
    var disposeBag = DisposeBag()
    
    init(view: SignUpViewController, registrationUseCase: RegistrationUseCase, userUseCase: userUseCase, settings: Settings) {
        self.view = view
        self.registrationUseCase = registrationUseCase
        self.userUsecase = userUseCase
        self.settings = settings
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
            .subscribe(onCompleted: {
                
            },
            onError: { [weak self] error in
            
            })
            .disposed(by: disposeBag)
    }
    
    func getUser() -> UserEntity? {
        return self.settings.account
    }
    
    func proceed(user: SignUpEntity) {
        
    }
    
    
}
