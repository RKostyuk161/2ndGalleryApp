//
//  SignInViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate  {
    var timer: Timer?
    var presenter: SignInPresenter!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func forgotButton(_ sender: UIButton) {
        
    }
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
    
    @IBOutlet weak var activityIndicatorView: UIView!
    
    @IBOutlet weak var customActiviyIndicator: UIImageView!
    
    
    
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
}

extension SignInViewController {
    
    func startTimer() {
        self.activityIndicatorView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    func stopTimer() {
        self.activityIndicatorView.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.customActiviyIndicator.transform = self.customActiviyIndicator.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}

