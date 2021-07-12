//
//  ProfileViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 11.06.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBAction func SettingsButton(_ sender: UIBarButtonItem) {
        presenter.routeToSettings()
    }
    var presenter: ProfilePresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileConfigurator.config(view: self)
    }
}
