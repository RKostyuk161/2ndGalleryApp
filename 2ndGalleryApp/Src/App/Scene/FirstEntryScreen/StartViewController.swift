//
//  ViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import RxSwift
import RxNetworkApiClient

class StartViewController: UIViewController {
    
    var router: StartRouter!
    
    @IBAction func signInButton(_ sender: UIButton) {
        router.openSingInScene()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        router.openSignUpScene()
    }
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartConfigurator().config(view: self)
        setupButtons()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.backgroundColor = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupButtons() {
        signUpButton.layer.cornerRadius = 10
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

