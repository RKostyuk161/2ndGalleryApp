//
//  SignUpViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import Foundation

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
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
        setupTextFieldsDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cancelButton = UIBarButtonItem.init(
              title: "",
              style: .done,
              target: self,
            action: #selector(back)
        )
        cancelButton.image = R.image.backButton()
        cancelButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
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
            Alerts().addAlert(alertTitle: "Error", alertMessage: "* fields is empty", buttonMessage: "Ok", view: self)
            return
        }
        
        if oldPasswordText != confirmPasswordText {
            Alerts().addAlert(alertTitle: "Error", alertMessage: "passwords not match", buttonMessage: "Ok", view: self)
        }
        let query: String? = (birthPasswordText.isEmpty) ? nil : birthPasswordText
        let user = SignUpEntity(username: userNameText,
                                birthday: query,
                                email: emailText,
                                password: confirmPasswordText)
        presenter.signUp(user: user)
    }
    
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
