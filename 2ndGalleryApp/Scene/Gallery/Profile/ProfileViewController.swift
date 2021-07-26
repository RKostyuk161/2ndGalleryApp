//
//  ProfileViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 11.06.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var currentUser: UserEntity?
    
    @IBOutlet weak var usersPostsCollectionView: UICollectionView!
    @IBAction func SettingsButton(_ sender: UIBarButtonItem) {
        presenter.routeToSettings()
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    var presenter: ProfilePresenter!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUser = getUser()
        textToLabels(currentUser: currentUser)
    }
    
    override func viewDidLoad() {
        ProfileConfigurator.config(view: self, currentUser: nil)
        super.viewDidLoad()
        navigationController?.reloadInputViews()
        currentUser = getUser()
//        usersPostsCollectionView.dataSource = self
        usersPostsCollectionView.delegate = self
        textToLabels(currentUser: currentUser)
    }
    
    func textToLabels(currentUser: UserEntity?) {
        guard let user = currentUser else { return }
        nameLabel.text = user.username ?? "no data"
        birthdayLabel.text = user.birthday ?? ""
    }
    
    func getUser() -> UserEntity? {
        return self.presenter.settings.account
    }
}
