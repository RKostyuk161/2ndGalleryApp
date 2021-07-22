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
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPassTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBAction func uploadProfilePhotoButton(_ sender: UIButton) {
    }
    
    @IBAction func deleteAccButton(_ sender: UIButton) {
        presenter.deleteAcc()
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        presenter.settings.clearUserData()
        let mainTabBar = R.storyboard.main.instantiateInitialViewController()!
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBar, flipFromRight: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileSettingsConfigurator().config(view: self)
        self.navigationController?.navigationBar.isHidden = false
        setupTextFields()
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
    
    @objc func backToProfile() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveChanges() {
        validateFieldsAndUpdateUserData()
    }
    
    func validateFieldsAndUpdateUserData() {
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
            presenter.saveSettings(image: profilePhoto.image ?? nil)
            self.navigationController?.reloadInputViews()

        }
    }
    func setupTextFields() {
        usernameTextField.delegate = self
        birthTextField.delegate = self
        emailTextField.delegate = self
        oldPassTextField.delegate = self
        newPassTextField.delegate = self
        confirmPassTextField.delegate = self
        
        presenter.setTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
                return false
    }
}
