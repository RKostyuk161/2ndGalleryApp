//
//  SignInPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import Foundation
import RxSwift

class SignInPresenterImp: SignInPresenter {
    
    var view: SignInViewController
    var loginUseCase: AuthUseCase
    var settings: Settings
    var disposeBag = DisposeBag()
    var router: SignInRouter
    
    init(view: SignInViewController, loginUseCase: AuthUseCase, settings: Settings, router: SignInRouter) {
        self.view = view
        self.loginUseCase = loginUseCase
        self.settings = settings
        self.router = router
    }
    
    func signIn(username: String, password: String) {
        self.loginUseCase.sighIn(login: username, password: password)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
            },
            onDispose: {
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let user = self.settings.account else {
                    return
                }
                
            },
            onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func openForgotPasswordScene() {
        
    }
    
}
