//
//  AddPhotoExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

extension AddPhotoViewController: BaseView {
    
    func addBottomAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: R.string.alert.cameraString(),
                                         style: .default) {
                    (action) in
                    self.cameraAccessCheck()
                }

        let libAction = UIAlertAction(title: R.string.alert.galleryString(),
                                      style: .default) {
                    (action) in
                    self.phoneLibAccessCheck()
                }

        let cancelAction = UIAlertAction(title: R.string.alert.cancelMessage(),
                                         style: .cancel) {_ in
                    
                }

                actionSheet.addAction(cameraAction)
                actionSheet.addAction(libAction)
                actionSheet.addAction(cancelAction)
                self.present(actionSheet, animated: true, completion: nil)
    }
    
    func addAlertToAddPhotos(alertTitle: String,
                             buttonOneMessage: String?,
                             buttonTwoMessage: String,
                             view: UIViewController) {
        
        let alert = UIAlertController(title: alertTitle,
                                      message: nil,
                                      preferredStyle: .alert)
        
        var buttonOne = UIAlertAction(title: buttonOneMessage,
                                   style: .cancel,
                                   handler: nil)
        var buttonTwo = UIAlertAction(title: buttonTwoMessage,
                                      style: .default,
                                   handler: nil)
        buttonOne = UIAlertAction(title: buttonOneMessage, style: .cancel) {
            (action) -> Void in
            return
        }
        
        buttonTwo =  UIAlertAction(title: buttonTwoMessage,
                                    style: .default) {
                (action) -> Void in
                self.routeToSettings()
            }
        
        alert.addAction(buttonOne)
        alert.addAction(buttonTwo)
        view.present(alert, animated: true, completion: nil)
    }
    
    func routeToSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
}

extension AddPhotoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        imagePerview.image = chosenImage
    }
}

