//
//  SignUpExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.08.2021.
//

import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
    }
    
    func setupTextFieldsDelegate() {
        emailTextField.delegate = self
        usernameTextField.delegate = self
        oldPasswordTextField.delegate = self
        confirmPassTextField.delegate = self
    }
}

extension SignUpViewController: SignUpView {
}
