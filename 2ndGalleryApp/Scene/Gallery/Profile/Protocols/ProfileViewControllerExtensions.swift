//
//  ProfileViewControllerExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.createNumberOfCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.createCellsForUsersItems(indexPath: indexPath)
    }
}

extension ProfilePresenterImp {
    func createCellsForUsersItems(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.usersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        imageUrl = userPhotoItems[indexPath.item]
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }
    
    func createNumberOfCells() -> Int {
        if userPhotoItems.count == 0 {
            view.showErrorOnGallery(show: true)
        } else {
            view.showErrorOnGallery(show: false)
        }
        print("nfhwienbfhwenfhwenbfnwbef", userPhotoItems)
        return self.userPhotoItems.count

    }
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.view.frame.width / CGFloat(itemsPerLine)-20, height: view.view.frame.width / CGFloat(itemsPerLine)-20)
    }
    
}
