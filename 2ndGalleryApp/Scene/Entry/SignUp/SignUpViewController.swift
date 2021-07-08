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
        presenter.signUp(user: SignUpEntity(username: "Roma", birthday: nil, email: "nfojnewnf@qwe.rqwe", password: "qwert"))
        
        
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
}
