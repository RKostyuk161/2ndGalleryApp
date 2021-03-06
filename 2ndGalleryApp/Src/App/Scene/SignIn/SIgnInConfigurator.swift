//
//  SIgnInConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 08.07.2021.
//

import UIKit

class SignInConfigurator {
    
    func config(view: SignInViewController)  {
        let router = SignInRouter(view: view)
        let presenter = SignInPresenterImp(view: view,
                                           loginUseCase: DI.resolve(),
                                           settings: DI.resolve(),
                                           router: router)
        
        view.presenter = presenter
    }
    static func open(navCon: UINavigationController) {
        let identifier = R.storyboard.signIn.signInViewController.identifier
        guard let vc = R.storyboard.signIn().instantiateViewController(withIdentifier: identifier) as? SignInViewController else { return }
        SignInConfigurator().config(view: vc)
        navCon.pushViewController(vc, animated: true)
        navCon.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
