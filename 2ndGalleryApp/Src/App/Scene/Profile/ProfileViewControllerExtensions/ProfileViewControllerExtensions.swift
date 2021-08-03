//
//  ProfileViewControllerExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.moveToFullImage(indexPath: indexPath)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter.setupSizeForCell(itemsPerLine: 4)
    }
}

extension ProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.createNumberOfCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.createCellsForUsersItems(indexPath: indexPath)
    }
}

extension ProfileViewController: ProfileView {
}
