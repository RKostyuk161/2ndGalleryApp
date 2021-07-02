//
//  SignInViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func forgotButton(_ sender: UIButton) {
        
    }
    
    @IBAction func singInButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MainGallery", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainGalleryTabBarController") as! UITabBarController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
