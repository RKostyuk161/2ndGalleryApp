//
//  ProfileSettingsViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import UIKit

class ProfileSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var presenter: ProfileSettingsPresenter!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPassTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    let datePicker = UIDatePicker()
    var currentDate: String?
    
    @IBAction func uploadProfilePhotoButton(_ sender: UIButton) {
    }
    
    @IBAction func deleteAccButton(_ sender: UIButton) {
        presenter.deleteAcc()
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        presenter.settings.clearUserData()
        presenter.changeRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setNavBarButtons()
        setDatePicker()
    }
    
    @objc func backToProfile() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveChanges() {
        validateFieldsAndUpdateUserData()
    }
    
    @objc func closeDataPicker() {
        view.endEditing(true)
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    func setNavBarButtons() {
        self.navigationController?.navigationBar.isHidden = false
        let saveButton = UIBarButtonItem.init(
              title: "Save",
              style: .done,
              target: self,
            action: #selector(saveChanges)
        )
        
        let cancelButton = UIBarButtonItem.init(
              title: "Cancel",
              style: .done,
              target: self,
            action: #selector(backToProfile)
        )
        saveButton.tintColor = #colorLiteral(red: 0.8443242908, green: 0.3406359553, blue: 0.6639499068, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthdayTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(closeDataPicker))
        self.view.addGestureRecognizer(tapped)
        let maxData = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = maxData
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        let humanFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        humanFormatter.dateFormat = "d MMM, yyyy"
        
        birthdayTextField.text = humanFormatter.string(from: datePicker.date)
        self.currentDate = formatter.string(from: datePicker.date)
    }
    
    
    func validateFieldsAndUpdateUserData() {
        checkUserSettings()
        checkPasswordFiels()
    }
    
    func checkUserSettings() {
        guard let username = usernameTextField.text,
              let email = emailTextField.text  else { return }
        
        if username == "" {
            Alerts().addAlert(alertTitle: "Error",
                              alertMessage: "username field is empty",
                              buttonMessage: "Ok",
                              view: self)
            return
        }
        
        if email == "" {
            Alerts().addAlert(alertTitle: "Error",
                              alertMessage: "email field is empty",
                              buttonMessage: "Ok",
                              view: self)
            return
        }
        
        if let newPass = newPassTextField.text,
           let confirmPass = confirmPassTextField.text {
            
            if confirmPass != "" &&
                newPass != confirmPass {
                Alerts().addAlert(alertTitle: "Error",
                                  alertMessage: "new and confirm fields are not match",
                                  buttonMessage: "Ok", view: self)
                return
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass == "" &&
                   newPass != "" {
                    Alerts().addAlert(alertTitle: "Error",
                                      alertMessage: "old pass field is empty",
                                      buttonMessage: "Ok",
                                      view: self)
                    return
                }
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass != "" &&
                    newPass != "" &&
                    confirmPass != newPass {
                    Alerts()
                        .addAlert(alertTitle: "Error",
                                  alertMessage: "new and confirm fields are not match",
                                  buttonMessage: "Ok",
                                  view: self)
                    return
                }
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass != "" &&
                    newPass == confirmPass &&
                    newPass == "" {
                    Alerts().addAlert(alertTitle: "Error",
                                      alertMessage: "fill all pass fields",
                                      buttonMessage: "Ok",
                                      view: self)
                    return
                }
            }
            presenter.saveSettings()
            self.navigationController?.reloadInputViews()

        }
    }
    
    func checkPasswordFiels() {
        if newPassTextField.text == confirmPassTextField.text {
            if oldPassTextField.text != "" {
                guard let oldPass = oldPassTextField.text,
                      let newPass = newPassTextField.text else { return }
                presenter.updatePass(oldPass: oldPass, newPass: newPass)
            } else {
                return
            }
        } else {
            return
        }
    }
    
    func setupTextFields() {
        usernameTextField.delegate = self
        birthdayTextField.delegate = self
        emailTextField.delegate = self
        oldPassTextField.delegate = self
        newPassTextField.delegate = self
        confirmPassTextField.delegate = self
        
        presenter.setTextFields()
    }
    
    func routeUsersData() -> UserEntity {
        guard let settings = presenter.settings.account,
              let id = settings.id else { return UserEntity(user: SignUpEntity()) }
        let user = UserEntity(id: id,
                              username: usernameTextField.text,
                              email: emailTextField.text,
                              pass: oldPassTextField.text,
                              dateOfBirth: currentDate)
        return user
    }
    
    func setTextFields() {
        usernameTextField.text = presenter.currentUser.username ?? "no data"
        emailTextField.text = presenter.currentUser.email ?? "no data"
        birthdayTextField.placeholder = presenter.currentUser.birthday ?? "no data"
        guard presenter.currentUser.birthday != nil else { return }
        birthdayTextField.text = HumanDateFormatter.currentUsersDate ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
    }
}
