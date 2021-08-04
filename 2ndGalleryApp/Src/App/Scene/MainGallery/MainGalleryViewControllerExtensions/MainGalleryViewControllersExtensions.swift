//
//  MainGalleryViewControllersExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import Foundation
import UIKit

extension MainGalleryViewController: MainGalleryView {
    func collectionViewReloadData() {
        self.galleryCollectionView.reloadData()
    }
    func collectionViewEndRefreshing() {
        self.collectionViewRefreshControl.endRefreshing()
    }
    func showErrorOnGallery(show: Bool) {
        switch show {
        case true:
            errorImage.isHidden = false

        default:
            errorImage.isHidden = true
        }
    }
    func getCGSizeForGalleryCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.frame.width / CGFloat(itemsPerLine)-20, height: view.frame.width / CGFloat(itemsPerLine)-20)
    }
    
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainGalleryCollectionViewCell.name, for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        switch presenter.currentCollection {
        case .new:
            imageUrl = presenter.newImageEntityArray[indexPath.item]
        case .popular:
            imageUrl = presenter.popularImageEntityArray[indexPath.item]
        }
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }
}

extension MainGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter.setupSizeForCell(itemsPerLine: setNumberOfCellsInRow)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
