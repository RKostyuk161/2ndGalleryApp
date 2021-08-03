//
//  ALerts.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

class Alerts {
    
    var selfFunc: (() -> Void)?
    
    func makeFunc(action: (() -> Void)? = nil)  {
        self.selfFunc = action
    }
    
    func addAlert(alertTitle: String,
                         alertMessage: String?,
                         buttonMessage: String,
                         view: UIViewController,
                         function: (() -> Void)? = nil) {
        
        function?()
        
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        var button = UIAlertAction(title: buttonMessage,
                                   style: .cancel,
                                   handler: nil)
        if function != nil {
            button =  UIAlertAction(title: buttonMessage,
                                    style: .cancel) {
                (action) -> Void in
                self.makeFunc(action: function)
                self.selfFunc!()
            }
        }
        
        alert.addAction(button)
        view.modalPresentationStyle = .overCurrentContext
        view.present(alert, animated: true, completion: nil)
    }
}
