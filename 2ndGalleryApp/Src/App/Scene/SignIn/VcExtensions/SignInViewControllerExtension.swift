//
//  SignInViewControllerExtension.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.08.2021.
//

import Foundation
import UIKit

extension SignInViewController: UITextFieldDelegate {
    func setupTextFieldsDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
    }
}

extension SignInViewController: SignInView {
}
