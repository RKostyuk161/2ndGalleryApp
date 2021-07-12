//
//  SignInViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    var presenter: SignInPresenter!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func forgotButton(_ sender: UIButton) {
        
    }
    @IBAction func singInButton(_ sender: UIButton) {
        checkFieldsAndAuth()
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        presenter.moveToSignUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SignInConfigurator().config(view: self)

    }
    
    func checkFieldsAndAuth() {
        
        guard let emailText = emailTextField.text,
              let oldPasswordText = passwordTextField.text else { return }

        if emailText.isEmpty,
           oldPasswordText.isEmpty {
            Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "field are clear", message: nil, view: self)
            
        } else {
            
            presenter.signIn(username: emailText, password: oldPasswordText)
        }
    }
}
