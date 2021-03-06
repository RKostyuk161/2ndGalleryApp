//
//  BaseView.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.08.2021.
//

import Foundation
import UIKit

protocol BaseView: AnyObject {
}

extension BaseView {
    
    func addInfoModuleWithFunc(alertTitle: String,
                           alertMessage: String?,
                           buttonMessage: String,
                           completion: (() -> Void)? = nil)  {
        guard let view = (self as? UIViewController) else { return }
        
        Alerts().addAlert(alertTitle: alertTitle,
                          alertMessage: alertMessage,
                          buttonMessage: buttonMessage,
                          view: view,
                          function: completion)
    }
    
    func addInfoModule(alertTitle: String,
                       alertMessage: String?,
                       buttonMessage: String)  {
        guard let view = (self as? UIViewController) else { return }
        Alerts().addAlert(alertTitle: alertTitle,
                          alertMessage: alertMessage,
                          buttonMessage: buttonMessage,
                          view: view)
    }
}
