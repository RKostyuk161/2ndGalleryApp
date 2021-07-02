//
//  RegistrationUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation
import RxSwift

protocol RegistrationUseCase {
    func signUp(entity: SignUpEntity) -> Single<UserEntity>
}
