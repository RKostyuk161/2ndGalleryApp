//
//  ProfileViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 11.06.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    
    @IBOutlet weak var usersPostsCollectionView: UICollectionView!
    @IBAction func SettingsButton(_ sender: UIBarButtonItem) {
        presenter.routeToSettings()
    }
    var presenter: ProfilePresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        usersPostsCollectionView.dataSource = self
        usersPostsCollectionView.delegate = self
        ProfileConfigurator().config(view: self)
    }
}
