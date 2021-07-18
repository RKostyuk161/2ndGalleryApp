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
    var activityIndicator = CustomActivityIndicatorImp()
    
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
                self.view.startTimer()
            },
            onDispose: {
                self.view.stopTimer()
                
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let user = self.settings.account else {
                    return
                }
                Alerts().addAlert(alertTitle: "Auth is ok",
                                  alertMessage: nil,
                                  buttonMessage: "Go to gallery",
                                  view: self.view,
                                  function: { [weak self] in
                                    self!.changeRootView()
                                  })
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
        let indefier = R.storyboard.signUp.signUpViewController.identifier
        let vc = R.storyboard.signUp().instantiateViewController(identifier: indefier)
        self.view.navigationController?.pushViewController(vc, animated: true)
        self.view.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func changeRootView() {
        let mainTabBar = R.storyboard.mainGallery.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
}
