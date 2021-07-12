//
//  SignUpViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import Foundation

class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenter!
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        checkFieldsAndReg()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpConfigurator().config(view: self)
    }

    func makeSignUp() {
        
    }
    
    func checkFieldsAndReg() {
        
        guard let userNameText = usernameTextField.text,
              let emailText = emailTextField.text,
              let oldPasswordText = oldPasswordTextField.text,
              let confirmPasswordText = confirmPassTextField.text,
              let birthPasswordText = birthdayTextField.text else { return }
        
        if userNameText.isEmpty,
           emailText.isEmpty,
           oldPasswordText.isEmpty,
           confirmPasswordText.isEmpty {
            return
        }
        
        if oldPasswordText != confirmPasswordText {
            return
        }
        let query: String? = (birthPasswordText.isEmpty) ? nil : birthPasswordText
        let user = SignUpEntity(username: userNameText,
                                birthday: query,
                                email: emailText,
                                password: confirmPasswordText)
        presenter.signUp(user: user)
    }
}
