//
//  SignUpViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenter!
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        presenter.signUp(user: SignUpEntity(username: "roma", dateOfBirth: "05041998", email: "roma@web.ru", pass: "qwe"))
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpConfigurator().config(view: self)
    }

    func makeSignUp() {
        
    }
}
