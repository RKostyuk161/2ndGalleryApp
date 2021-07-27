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
    
    init(view: SignInViewController,
         loginUseCase: AuthUseCase,
         settings: Settings,
         router: SignInRouter) {
        self.view = view
        self.loginUseCase = loginUseCase
        self.settings = settings
        self.router = router
    }
    
    func signIn(username: String, password: String) {
        self.loginUseCase.sighIn(login: username, password: password)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            },
            onDispose: {
                self.view.presentedViewController?.dismiss(animated: true, completion: nil)
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let _ = self.settings.account else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Alerts().addAlert(alertTitle: "Auth is ok",
                                  alertMessage: nil,
                                  buttonMessage: "Go to gallery",
                                  view: self.view,
                                  function: { [weak self] in
                                    self!.changeRootView()
                                  })
                }
            },
            onError: { error in
                Alerts().addAlert(alertTitle: "Error",
                                  alertMessage: error.localizedDescription,
                                  buttonMessage: "Ok",
                                  view: self.view)
            })
            .disposed(by: disposeBag)
    }
        
    func moveToSignUp() {
        guard let navCon = self.view.navigationController else { return }
        router.openSignUpScreen(navigationController: navCon)
    }
    
    func changeRootView() {
        router.openMainGallery()
    }
    
}
