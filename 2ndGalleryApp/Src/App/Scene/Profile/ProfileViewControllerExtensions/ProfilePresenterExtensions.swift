//
//  ProfilePresenterExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

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
        return CGSize(width: view.view.frame.width / CGFloat(itemsPerLine)-10, height: view.view.frame.width / CGFloat(itemsPerLine)-10)
    }
    
    func moveToFullImage(indexPath: IndexPath) {
        let model = userPhotoItems[indexPath.item]
        let userModel = getSelfUserModel()
        guard let nc = self.view.getNavigationController() else { return }
        FullImageInfoConfigurator.open(navigationController: nc,
                                       imageModel: model,
                                       userModel: userModel)
    }
    
    func getSelfUserModel() -> UserEntity {
        let model = UserEntity(user: SignUpEntity())
        guard let name = settings.account?.username,
              let bitrh = settings.account?.birthday else { return model }
        model.username = name
        model.birthday = bitrh
        return model
    }
}
