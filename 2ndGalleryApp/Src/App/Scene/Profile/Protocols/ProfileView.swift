//
//  ProfileView.swift
//  2ndGalleryApp
//
//  Created by Роман on 03.08.2021.
//

import Foundation
import UIKit

protocol ProfileView: BaseView {
    func showErrorOnGallery(show: Bool)
    func collectionViewReloadData()
}
