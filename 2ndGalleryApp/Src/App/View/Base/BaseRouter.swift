//
//  BaseRouter.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation
import UIKit

protocol BaseRouter {
    var view: UIViewController! { get }
}

extension BaseRouter {
    
    func dismissPresentedController() {
        guard let view = self.view else { return }
        view.dismiss(animated: true, completion: nil)
    }
    
    func popViewController() {
        guard let view = self.view else { return }
        view.navigationController?.popViewController(animated: true)
    }
    
    func getNavigationController() -> UINavigationController? {
        guard let navigationController = self.view.navigationController else { return nil }
        return navigationController
    }
}
