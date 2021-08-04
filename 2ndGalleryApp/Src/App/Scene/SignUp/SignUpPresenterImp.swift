//
//  SignUpPresenterImp.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation
import RxSwift

class SignUpPresenterImp: SignUpPresenter {

    weak var view: SignUpView?
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
        guard let usersEmail = user.email,
              let usersPass = user.password else { return }
        self.logingUseCase.logout()
        self.registrationUseCase.signUp(entity: user)
            .asCompletable()
            .observeOn(MainScheduler.instance)
            .andThen(self.logingUseCase.sighIn(login: usersEmail,
                                               password: usersPass))
            .do(onSubscribe: {
                CustomActivityIndicatorConfigurator.open()
            }, onDispose: {
                self.router.dismissPresentedController()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.view?.addInfoModuleWithFunc(alertTitle: R.string.alert.authIsOkMessage(),
                                                     alertMessage: nil,
                                                     buttonMessage: R.string.alert.okMessage(),
                                                     completion: { [weak self] in
                                                        self?.changeRootView()
                                                     })
                }

            },

            onError: { [weak self] error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.view?.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                                              alertMessage: error.localizedDescription,
                                              buttonMessage: R.string.alert.okMessage())
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getUser() -> UserEntity? {
        return self.settings.account
    }
    
    func changeRootView() {
        router.openMainGallery()
    }
    
    func openSignInScene() {
        guard let navigationController = self.router.getNavigationController() else { return }
        router.openSignInScreen(navigationController: navigationController)
    }
}
