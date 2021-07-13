//
//  ProfileSettingsViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
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
        
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        presenter.settings.clearUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileSettingsConfigurator().config(view: self)
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
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc func backToProfile() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveChanges() {
        print("hehreqwehqwheqwhe")
        validateFieldsAndUpdateUserData()
    }
    
    
    
    
    
    func validateFieldsAndUpdateUserData() {
        guard let username = usernameTextField.text,
              let email = emailTextField.text  else { return }
        
        if username == "" {
            Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "username field is empty", message: nil, view: self)
        }
        
        if email == "" {
            Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "email field is empty", message: nil, view: self)
        }
        
        if let newPass = newPassTextField.text,
           let confirmPass = confirmPassTextField.text {
            
            if confirmPass != "" &&
                newPass != confirmPass {
                Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "new and confirm fields are not match", message: nil, view: self)
                return
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass == "" &&
                   newPass != "" {
                    Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "old pass field is empty", message: nil, view: self)
                    return
                }
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass != "" &&
                    newPass != "" &&
                    confirmPass != newPass {
                    Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "new and confirm fields are not match", message: nil, view: self)
                    return
                }
            }
            
            if let oldPass = oldPassTextField.text {
                if oldPass != "" &&
                    newPass == confirmPass &&
                    newPass == "" {
                    Alerts.addAlert(hasErrors: true, alertType: .auth, alertTitle: "fill all pass fields", message: nil, view: self)
                    return
                }
            }
            
            self.navigationController?.popViewController(animated: true)

        }
    }
}
