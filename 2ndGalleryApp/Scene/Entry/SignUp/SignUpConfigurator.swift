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
        let router = SignUpRouter()
        let presenter = SignUpPresenterImp(view: view,
                                           registrationUseCase: DI.resolve(),
                                           userUseCase: DI.resolve(),
                                           settings: DI.resolve())
        view.presenter = presenter
    }
}
