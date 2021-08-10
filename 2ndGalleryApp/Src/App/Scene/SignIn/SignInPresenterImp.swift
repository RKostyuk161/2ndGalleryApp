//
//  SignInPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import Foundation
import RxSwift

class SignInPresenterImp: SignInPresenter {
    
    weak var view: SignInView?
    var loginUseCase: AuthUseCase
    var settings: Settings
    var disposeBag = DisposeBag()
    var router: SignInRouter
    
    
    init(view: SignInView,
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
                self.router.dismissPresentedController()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self,
                      let _ = self.settings.account else { return }
                
                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.alert.authIsOkMessage(),
                                                    alertMessage: nil,
                                                    buttonMessage: R.string.alert.okMessage(),
                                                    completion: { [weak self] in
                                                        self?.changeRootView()
                                                    })
            },
            onError: { error in
                    self.view?.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                            alertMessage: error.localizedDescription,
                                            buttonMessage: R.string.alert.okMessage())
            })
            .disposed(by: disposeBag)
    }
    
    func openSignUpScene() {
        guard let navigationController = self.router.getNavigationController() else { return }
        router.openSignUpScreen(navigationController: navigationController)
    }
    
    func changeRootView() {
        router.openMainGallery()
    }
    
}
