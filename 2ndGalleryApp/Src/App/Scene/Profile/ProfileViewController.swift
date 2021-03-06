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
    @IBOutlet weak var errorIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    var presenter: ProfilePresenter!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.reloadInputViews()
        presenter.setUser()
        textToLabels(currentUser: presenter.getUser())
        presenter.getCurrentUserImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileConfigurator.config(view: self, currentUser: nil)
        makeViewDidLoadSetup()
    }
    
    func textToLabels(currentUser: UserEntity?) {
        guard let user = currentUser else { return }
        nameLabel.text = user.username ?? "no data"
        birthdayLabel.text = HumanDateFormatter.currentUsersDate ?? ""
    }
    
    func showErrorOnGallery(show: Bool) {
        if show {
            self.errorIcon.isHidden = false
        } else {
            self.errorIcon.isHidden = true
        }
    }
    
    func collectionViewReloadData() {
        self.usersPostsCollectionView.reloadData()
    }
    
    func makeViewDidLoadSetup() {
        presenter.setUser()
        let galleryCellName = R.nib.mainGalleryCollectionViewCell.name
        self.usersPostsCollectionView.register(UINib(nibName: galleryCellName,
                                                  bundle: nil),
                                            forCellWithReuseIdentifier: galleryCellName)
        usersPostsCollectionView.dataSource = self
        usersPostsCollectionView.delegate = self
        textToLabels(currentUser: presenter.getUser())
        presenter.subscribeOnUserImages()
    }
    
    func getCGSizeForGalleryCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.frame.width / CGFloat(itemsPerLine)-10, height: view.frame.width / CGFloat(itemsPerLine)-10)
    }

}
