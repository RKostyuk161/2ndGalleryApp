//
//  ALerts.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

enum AlertType {
    case auth
    case reg
    case gallery
}

class Alerts {
   static func addAlert(hasErrors: Bool, alertType: AlertType, alertTitle: String, message: String?, view: UIViewController) {
        let alert = UIAlertController(title: alertTitle,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        switch alertType {
        case .auth:
            if !hasErrors {
                let moveToGallery = UIAlertAction(title: alertTitle,
                                         style: UIAlertAction.Style.default) {
                    (moveToGallery) -> Void in
                    alert.addAction(moveToGallery)
                }
                alert.addAction(moveToGallery)
                view.present(alert, animated: true, completion: nil)
            } else {
                let showError = UIAlertAction(title: alertTitle,
                                         style: UIAlertAction.Style.default) {
                    (moveToGallery) -> Void in
                    alert.addAction(moveToGallery)
                }
                alert.addAction(showError)
                view.present(alert, animated: true, completion: nil)
            }
        case .reg:
            if !hasErrors {
                let moveToGallery = UIAlertAction(title: alertTitle,
                                         style: UIAlertAction.Style.default) {
                    (moveToGallery) -> Void in
                    alert.addAction(moveToGallery)
                }
                alert.addAction(moveToGallery)
                view.present(alert, animated: true, completion: nil)
            } else {
                let showError = UIAlertAction(title: alertTitle,
                                         style: UIAlertAction.Style.default) {
                    (moveToGallery) -> Void in
                    alert.addAction(moveToGallery)
                }
                alert.addAction(showError)
                view.present(alert, animated: true, completion: nil)
            }
        case .gallery:
            if !hasErrors {
                
            }
        }
    }
}
