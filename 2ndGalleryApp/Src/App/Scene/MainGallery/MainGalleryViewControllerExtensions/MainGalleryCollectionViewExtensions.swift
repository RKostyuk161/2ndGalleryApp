//
//  MainGalleryCollectionViewExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

extension MainGalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.reuseIdentifier.mainGalleryFooterCollectionReusableView, for: indexPath) {
                if self.isLastPaginationPage == true {
                    footerView.isHidden = true
                } else {
                    footerView.isHidden = false
                }
                return footerView
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.prepeareForRoute(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch presenter.currentGalleryState {
        case .gallery:
            self.saveIndexPathToScroll(indexPath: indexPath)
          presenter.getMoreImages(collectionType: presenter.currentCollection, indexPath: indexPath)
        default:
            return
        }
    }
}

extension MainGalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.setupNumberOfCellsForMainGalleryCollectionView(collectionType: presenter.currentCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        createCellForMainGalleryCollectionView(indexPath: indexPath)
    }
}

extension MainGalleryViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isLastPaginationPage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)  {
            self.presenter.currentGalleryState = .search
            self.galleryCollectionView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)  {
            
            if searchBar.text == "" {
                self.presenter.currentGalleryState = .gallery
                self.galleryCollectionView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let imageName = searchBar.text else { return }
        self.presenter.getSearchImagesRequest(imageName: imageName, currentCollection: self.presenter.currentCollection)
        self.galleryCollectionView.reloadData()
        self.galleryCollectionView.reloadData()
    }
}
