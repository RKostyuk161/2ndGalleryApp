//
//  ProfileSettingsViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    var presenter: ProfileSettingsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileSettingsConfigurator().config(view: self)
        self.navigationController?.navigationBar.isHidden = false
        let saveButton = UIBarButtonItem.init(
              title: "Save",
              style: .done,
              target: self,
            action: Selector("rightButtonAction:")
        )

        self.navigationItem.rightBarButtonItem = saveButton
    }

}
