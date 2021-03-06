//
//  ProfilePresenterExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

extension ProfileViewController {
    func createCellsForUsersItems(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        imageUrl = presenter.userPhotoItems[indexPath.item]
        if let url = imageUrl.image?.name {
            cell.setupCell(url: url)
        }
        return cell
    }
    
    func createNumberOfCells() -> Int {
        if presenter.userPhotoItems.count == 0 {
            showErrorOnGallery(show: true)
        } else {
            showErrorOnGallery(show: false)
        }
        return presenter.userPhotoItems.count
    }
}
