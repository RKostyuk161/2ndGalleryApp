//
//  StartRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 05.07.2021.
//

import Foundation
import UIKit

class StartRouter {
    
    weak var view: UIViewController!
    
    init(view: StartViewController) {
        self.view = view
    }
    
    func openSignUpScene() {
        guard let navigationController = self.view.navigationController else { return }
        SignUpConfigurator.open(navigationController: navigationController)
    }
    
    func openSingInScene() {
        guard let navigationController = self.view.navigationController else { return }
        SignInConfigurator.open(navCon: navigationController)
    }
}
