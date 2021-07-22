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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    var presenter: ProfilePresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.reloadInputViews()
//        usersPostsCollectionView.dataSource = self
        usersPostsCollectionView.delegate = self
        ProfileConfigurator().config(view: self)
        textToLabels()
    }
    
    func textToLabels() {
        guard let user = self.getUser() else { return }
        nameLabel.text = user.name ?? "no data"
        birthdayLabel.text = user.birthday ?? ""
    }
    
    func getUser() -> UserEntity? {
        return self.presenter.settings.account
    }
}
