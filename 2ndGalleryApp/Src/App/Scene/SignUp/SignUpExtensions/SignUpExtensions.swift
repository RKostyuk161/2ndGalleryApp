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
        let starSymbol  = NSMutableAttributedString(string: " *",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        emailTextField.attributedPlaceholder = makePlaceholderRedStar(left: NSAttributedString(string: "E-mail"), right: starSymbol)
        usernameTextField.attributedPlaceholder = makePlaceholderRedStar(left: NSAttributedString(string: "Username"), right: starSymbol)
        oldPasswordTextField.attributedPlaceholder = makePlaceholderRedStar(left: NSAttributedString(string: "Old Password"), right: starSymbol)
        confirmPassTextField.attributedPlaceholder = makePlaceholderRedStar(left: NSAttributedString(string: "Confirm Password"), right: starSymbol)
    }
    
    func makePlaceholderRedStar (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}

extension SignUpViewController: SignUpView {
}
