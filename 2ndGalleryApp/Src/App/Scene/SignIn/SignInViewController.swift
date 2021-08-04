//
//  SignInViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignInViewController: UIViewController  {

    var presenter: SignInPresenter!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func singInButton(_ sender: UIButton) {
        checkFieldsAndAuth()
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        presenter.openSignUpScene()
    }
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldsDelegate()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarItem()
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }    
    
    func checkFieldsAndAuth() {
        guard let emailText = emailTextField.text,
              let oldPasswordText = passwordTextField.text else { return }

        if emailText.isEmpty,
           oldPasswordText.isEmpty {
            addInfoModule(alertTitle: R.string.alert.errorMessage(),
                          alertMessage: R.string.alert.emptyFieldsMessage(),
                          buttonMessage: R.string.alert.okMessage())
        } else {
            presenter.signIn(username: emailText, password: oldPasswordText)
        }
    }
    
    func setupNavigationBarItem() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func setupButtons() {
        signInButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

