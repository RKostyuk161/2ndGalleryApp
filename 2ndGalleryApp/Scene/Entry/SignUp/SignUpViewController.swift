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
    let datePicker = UIDatePicker()
    
    @IBAction func signUpButton(_ sender: UIButton) {
        checkFieldsAndReg()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        goToSignUp()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpConfigurator().config(view: self)
        setupTextFieldsDelegate()
        setDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarItem()
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func closeDataPicker() {
        view.endEditing(true)
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayTextField.text = formatter.string(from: datePicker.date)
    }
    
    func goToSignUp() {
        presenter.goToSignInScreen()
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
    
    func setDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        birthdayTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(closeDataPicker))
        self.view.addGestureRecognizer(tapped)
        let maxData = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = maxData
    }
    
    func setNavBarItem() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
