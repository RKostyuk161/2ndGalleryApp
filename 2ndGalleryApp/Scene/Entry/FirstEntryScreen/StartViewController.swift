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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartConfigurator().config(view: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.backgroundColor = nil
    }

}

