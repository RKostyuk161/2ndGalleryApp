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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    let datePicker = UIDatePicker()
    var currentDate: String?
    
    @IBAction func signUpButton(_ sender: UIButton) {
        checkFieldsAndReg()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        routeToSignUpScreen()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldsDelegate()
        setDatePicker()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem()
    }
    
    @objc func navigationControllerLeftButtonAction() {
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
        let humanFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        humanFormatter.dateFormat = "d MMM, yyyy"
        
        birthdayTextField.text = humanFormatter.string(from: datePicker.date)
        self.currentDate = formatter.string(from: datePicker.date)
        HumanDateFormatter.currentUsersDate = humanFormatter.string(from: datePicker.date)
    }
    
    func routeToSignUpScreen() {
        presenter.openSignInScene()
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
            self.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                               alertMessage: R.string.alert.emptyFieldsMessage(),
                               buttonMessage: R.string.alert.okMessage())
            return
        }
        
        if oldPasswordText != confirmPasswordText {
            self.addInfoModule(alertTitle: R.string.alert.errorMessage(),
                               alertMessage: R.string.alert.passwordsNotMatch(),
                               buttonMessage: R.string.alert.okMessage())
        }
        
        let query: String? = (birthPasswordText.isEmpty) ? nil : currentDate
        let user = SignUpEntity(username: userNameText,
                                birthday: query,
                                email: emailText,
                                password: confirmPasswordText)
        presenter.signUp(user: user)
    }
    
    func setDatePicker() {
//        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthdayTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(closeDataPicker))
        self.view.addGestureRecognizer(tapped)
        let maxData = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = maxData
    }
    
    func setNavigationBarItem() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let cancelButton = UIBarButtonItem.init(
              title: "",
              style: .done,
              target: self,
            action: #selector(navigationControllerLeftButtonAction)
        )
        cancelButton.image = R.image.backButton()
        cancelButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    func setupButtons() {
        signUpButton.layer.cornerRadius = 10
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
