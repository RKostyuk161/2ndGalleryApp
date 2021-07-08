//
//  SIgnInConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import Foundation

class SignInConfigurator {
    func config(view: SignInViewController)  {
        let router = SignInRouter()
        let presenter = SignInPresenterImp(view: view,
                                           loginUseCase: DI.resolve(),
                                           settings: DI.resolve(),
                                           router: router)
        
        view.presenter = presenter
    }
}
