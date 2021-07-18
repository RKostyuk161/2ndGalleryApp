//
//  AddPhotoUseCase\.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import Foundation
import RxSwift

protocol AddPhotoUseCase {
    func addPhoto() -> Completable
}
