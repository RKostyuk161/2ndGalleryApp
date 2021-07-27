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
        guard let navCon = self.view.navigationController else { return }
        SignUpConfigurator.open(navigationController: navCon)
    }
    
    func openSingInScene() {
        guard let navCon = self.view.navigationController else { return }
        SignInConfigurator.open(navCon: navCon)
    }
}
