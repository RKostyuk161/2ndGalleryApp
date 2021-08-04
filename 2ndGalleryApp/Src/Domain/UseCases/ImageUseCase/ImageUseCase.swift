//
//  ImageUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation

import RxSwift

protocol ImageUseCase {
    var source: PublishSubject<[ImageEntity]> { get }
    var userTotalItemsOfImages: Int { get }
    var userItems: [ImageEntity] { get }
    var imageModel: ImageEntity { get }
    
    func addPhoto(image: UIImage, name: String, description: String) -> Completable
    func postPhoto(photo: UploadPhoto) -> Completable
    func getUserImages(userId: Int) -> Completable
}

