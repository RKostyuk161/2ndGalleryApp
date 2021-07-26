//
//  AddChosenPhotoPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import UIKit
import RxSwift

protocol AddChosenPhotoPresenter {
    var image: UIImage { get }
    
    func addPhoto(image: UIImage, name: String, description: String)
}
