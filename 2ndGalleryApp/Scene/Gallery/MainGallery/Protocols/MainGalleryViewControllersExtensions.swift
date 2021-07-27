//
//  MainGalleryViewControllersExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
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
        presenter.createCellForMainGalleryCollectionView(indexPath: indexPath)
    }
}

extension MainGalleryViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isLastPaginationPage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)  {
            self.presenter.currentGalleryState = .search
            print(".search = \(self.presenter.currentGalleryState)")
            self.galleryCollectionView.reloadData()
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)  {
//
//        }
//    }
    
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
        self.presenter.getSearchImagesRequest(imageName: searchBar.text!, currentCollection: self.presenter.currentCollection)
        self.galleryCollectionView.reloadData()
        self.galleryCollectionView.reloadData()

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

extension UISegmentedControl {
    func removeBorder() {
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 67/255, green: 129/255, blue: 244/255, alpha: 1.0)], for: .selected)
    }

    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat =  UIScreen.main.bounds.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1.0)
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage {

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension MainGalleryPresenterImp {
    func createCellForMainGalleryCollectionView(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = view.galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "MainGalleryCollectionViewCell", for: indexPath) as! MainGalleryCollectionViewCell
        var imageUrl = ImageEntity()
        
        switch currentGalleryState {
        case .gallery:
            switch currentCollection {
            case .new:
                imageUrl = newImageEntityArray[indexPath.item]
            case .popular:
                imageUrl = popularImageEntityArray[indexPath.item]
            }
        case .search:
            view.isLastPaginationPage = true
            switch currentCollection {
            case .new:
                newImageEntityArray = searchItemsEntityArray
                imageUrl = newImageEntityArray[indexPath.item]
            case .popular:
                popularImageEntityArray = searchItemsEntityArray
                imageUrl = popularImageEntityArray[indexPath.item]
            }
        }
        cell.setupCell(url: (imageUrl.image?.name)!)
        return cell
    }
    
    func setupNumberOfCellsForMainGalleryCollectionView(collectionType: CollectionType) -> Int {
        
        switch currentGalleryState {
        case .gallery:
            switch currentCollection {
            case .new:
                return newImageEntityArray.count
            case .popular:
                return popularImageEntityArray.count
            }
        case .search:
            return searchItemsEntityArray.count
        }
    }
    
    func setupSizeForCell(itemsPerLine: Int) -> CGSize {
        return CGSize(width: view.view.frame.width / CGFloat(itemsPerLine)-20, height: view.view.frame.width / CGFloat(itemsPerLine)-20)
    }
}
