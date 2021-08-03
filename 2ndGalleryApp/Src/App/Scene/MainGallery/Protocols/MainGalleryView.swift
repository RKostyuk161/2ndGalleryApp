//
//  MainGalleryView.swift
//  2ndGalleryApp
//
//  Created by Роман on 02.08.2021.
//

import Foundation
import UIKit

protocol MainGalleryView: BaseView {
    var isLastPaginationPage: Bool { get set }
    func collectionViewReloadData()
    func collectionViewEndRefreshing()
    func showErrorOnGallery(show: Bool)
    func getCGSizeForGalleryCell(itemsPerLine: Int) -> CGSize
}
