//
//  SignUpConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import UIKit

class SignUpConfigurator {
    func config(view: SignUpViewController) {
        let router = SignUpRouter(view: view)
        let presenter = SignUpPresenterImp(view: view,
                                           registrationUseCase: DI.resolve(),
                                           userUseCase: DI.resolve(),
                                           settings: DI.resolve(),
                                           router: router,
                                           loginUseCase: DI.resolve())
        view.presenter = presenter
    }
    static func open(navigationController: UINavigationController) {
        let identifier = R.storyboard.signUp.signUpViewController.identifier
        let vc = R.storyboard.signUp().instantiateViewController(withIdentifier: identifier)
        SignUpConfigurator().config(view: vc as! SignUpViewController)
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
