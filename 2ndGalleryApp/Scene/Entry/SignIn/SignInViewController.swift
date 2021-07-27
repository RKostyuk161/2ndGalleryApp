//
//  SignInViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate  {

    var presenter: SignInPresenter!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func singInButton(_ sender: UIButton) {
        checkFieldsAndAuth()
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        presenter.moveToSignUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SignInConfigurator().config(view: self)
        setupTextFieldsDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarItem()
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }    
    
    func checkFieldsAndAuth() {
        guard let emailText = emailTextField.text,
              let oldPasswordText = passwordTextField.text else { return }

        if emailText.isEmpty,
           oldPasswordText.isEmpty {
            Alerts().addAlert(alertTitle: "field are clear",
                            alertMessage: nil,
                            buttonMessage: "ok",
                            view: self,
                            function: nil)
        } else {
            presenter.signIn(username: emailText, password: oldPasswordText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
    }
    
    func setupTextFieldsDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupNavBarItem() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
}

