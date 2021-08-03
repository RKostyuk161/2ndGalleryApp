//
//  AddChosenPhotoExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

extension AddChosenPhotoViewController: AddChosenPhotoView {
}

extension AddChosenPhotoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
